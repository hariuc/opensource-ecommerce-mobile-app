import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/error_mapper.dart';
import '../../data/models/returns_models.dart';
import '../../data/repository/account_repository.dart';

// ─── EVENTS ───

abstract class ReturnsEvent extends Equatable {
  const ReturnsEvent();

  @override
  List<Object?> get props => [];
}

/// Load customer returns from API (initial or refresh)
class LoadReturns extends ReturnsEvent {
  final int? statusFilter;
  const LoadReturns({this.statusFilter});

  @override
  List<Object?> get props => [statusFilter];
}

/// Load next page of returns (pagination)
class LoadMoreReturns extends ReturnsEvent {
  const LoadMoreReturns();
}

/// Clear transient error/success messages
class ClearReturnsMessage extends ReturnsEvent {
  const ClearReturnsMessage();
}

// ─── STATE ───

enum ReturnsStatus { initial, loading, loaded, error }

class ReturnsState extends Equatable {
  static const Object _endCursorUnchanged = Object();

  final ReturnsStatus status;
  final List<CustomerReturn> returns;
  final int totalCount;
  final bool hasNextPage;
  final String? endCursor;
  final bool isLoadingMore;
  final String? errorMessage;
  final int? statusFilter;

  const ReturnsState({
    this.status = ReturnsStatus.initial,
    this.returns = const [],
    this.totalCount = 0,
    this.hasNextPage = false,
    this.endCursor,
    this.isLoadingMore = false,
    this.errorMessage,
    this.statusFilter,
  });

  ReturnsState copyWith({
    ReturnsStatus? status,
    List<CustomerReturn>? returns,
    int? totalCount,
    bool? hasNextPage,
    Object? endCursor = _endCursorUnchanged,
    bool? isLoadingMore,
    String? errorMessage,
    int? statusFilter,
  }) {
    return ReturnsState(
      status: status ?? this.status,
      returns: returns ?? this.returns,
      totalCount: totalCount ?? this.totalCount,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      endCursor: identical(endCursor, _endCursorUnchanged)
          ? this.endCursor
          : endCursor as String?,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }

  @override
  List<Object?> get props => [
    status,
    returns,
    totalCount,
    hasNextPage,
    endCursor,
    isLoadingMore,
    errorMessage,
    statusFilter,
  ];
}

// ─── BLOC ───

class ReturnsBloc extends Bloc<ReturnsEvent, ReturnsState> {
  final AccountRepository repository;

  ReturnsBloc({required this.repository}) : super(const ReturnsState()) {
    on<LoadReturns>(_onLoad);
    on<LoadMoreReturns>(_onLoadMore);
    on<ClearReturnsMessage>(_onClearMessage);
  }

  Future<void> _onLoad(LoadReturns event, Emitter<ReturnsState> emit) async {
    emit(
      state.copyWith(
        status: ReturnsStatus.loading,
        statusFilter: event.statusFilter,
      ),
    );

    try {
      final result = await repository.getCustomerReturns(
        first: 20,
        status: event.statusFilter,
      );

      emit(
        state.copyWith(
          status: ReturnsStatus.loaded,
          returns: result.returns,
          totalCount: result.totalCount,
          hasNextPage: result.hasNextPage,
          endCursor: result.endCursor,
        ),
      );
    } catch (e) {
      debugPrint('❌ ReturnsBloc._onLoad error: $e');
      emit(
        state.copyWith(
          status: ReturnsStatus.error,
          errorMessage: ErrorMapper.getUserMessage(
            e,
            context: 'loading returns',
          ),
        ),
      );
    }
  }

  Future<void> _onLoadMore(
    LoadMoreReturns event,
    Emitter<ReturnsState> emit,
  ) async {
    if (!state.hasNextPage || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final result = await repository.getCustomerReturns(
        first: 20,
        after: state.endCursor,
        status: state.statusFilter,
      );

      emit(
        state.copyWith(
          status: ReturnsStatus.loaded,
          returns: [...state.returns, ...result.returns],
          totalCount: result.totalCount,
          hasNextPage: result.hasNextPage,
          endCursor: result.endCursor,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      debugPrint('❌ ReturnsBloc._onLoadMore error: $e');
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: ErrorMapper.getUserMessage(
            e,
            context: 'loading more returns',
          ),
        ),
      );
    }
  }

  void _onClearMessage(ClearReturnsMessage event, Emitter<ReturnsState> emit) {
    emit(state.copyWith(errorMessage: null));
  }
}
