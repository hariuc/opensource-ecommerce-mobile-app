/*
 *   Webkul Software.
 *   @package Mobikul Application Code.
 *   @Category Mobikul
 *   @author Webkul <support@webkul.com>
 *   @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *   @license https://store.webkul.com/license.html
 *   @link https://store.webkul.com/license.html
 */

import '../data_model/new_product_data.dart';

abstract class HomePageEvent {}

class FetchAddWishlistHomepageEvent extends HomePageEvent {
  NewProducts? datum;
  String? productId;
  FetchAddWishlistHomepageEvent(this.productId, this.datum);
}

class RemoveWishlistItemEvent extends HomePageEvent {
  NewProducts? datum;
  String? productId;
  RemoveWishlistItemEvent(this.productId, this.datum);
}

class AddToCartEvent extends HomePageEvent {
  int productId;
  int quantity;
  String? message;
  AddToCartEvent(this.productId, this.quantity, this.message);
}

class AddToCompareHomepageEvent extends HomePageEvent {
  String? productId;
  final String? message;
  AddToCompareHomepageEvent(this.productId, this.message);
}

class CartCountEvent extends HomePageEvent {}

class FetchAllProductsEvent extends HomePageEvent {
  List<Map<String, dynamic>>? filters;
  String id;
  FetchAllProductsEvent(this.filters, this.id);
}

class FetchHomeCustomData extends HomePageEvent {}

class CustomerDetailsEvent extends HomePageEvent {}

class FetchHomePageCategoriesEvent extends HomePageEvent {
  List<Map<String, dynamic>>? filters;
  FetchHomePageCategoriesEvent({this.filters});
}

class OnClickLoaderEvent extends HomePageEvent {
  final bool? isReqToShowLoader;
  OnClickLoaderEvent({this.isReqToShowLoader});
}
class FetchCMSDataEvent extends HomePageEvent {}

class SubscribeNewsLetterEvent extends HomePageEvent {
  String email;
  SubscribeNewsLetterEvent(this.email);
}
