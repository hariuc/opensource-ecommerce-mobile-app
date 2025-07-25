/*
 *   Webkul Software.
 *   @package Mobikul Application Code.
 *   @Category Mobikul
 *   @author Webkul <support@webkul.com>
 *   @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *   @license https://store.webkul.com/license.html
 *   @link https://store.webkul.com/license.html
 */

import 'package:bagisto_app_demo/screens/add_review/utils/index.dart';

abstract class AddReviewBaseState {}

enum AddReviewStatus { success, fail }

class AddReviewInitialState extends AddReviewBaseState {
  List<Object> get props => [];
}

class AddReviewFetchState extends AddReviewBaseState {
  AddReviewStatus? status;
  String? error;
  String? successMsg;
  AddReviewModel? addReviewModel;

  AddReviewFetchState.success({this.addReviewModel, this.successMsg})
      : status = AddReviewStatus.success;

  AddReviewFetchState.fail({this.error}) : status = AddReviewStatus.fail;

  List<Object> get props =>
      [if (addReviewModel != null) addReviewModel! else ""];
}

class ImagePickerState extends AddReviewBaseState {
  List<XFile?>? pickedFile;
  ImagePickerState(this.pickedFile);
}
