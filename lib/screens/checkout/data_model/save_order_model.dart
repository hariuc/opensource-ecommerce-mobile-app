/*
 *   Webkul Software.
 *   @package Mobikul Application Code.
 *   @Category Mobikul
 *   @author Webkul <support@webkul.com>
 *   @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *   @license https://store.webkul.com/license.html
 *   @link https://store.webkul.com/license.html
 */

import 'package:json_annotation/json_annotation.dart';

import '../../../data_model/graphql_base_model.dart';
part 'save_order_model.g.dart';

@JsonSerializable()
class SaveOrderModel extends BaseModel {
  String? redirectUrl;
  // String? selectedMethod;
  Order? order;
  SaveOrderModel({this.redirectUrl, this.order});

  factory SaveOrderModel.fromJson(Map<String, dynamic> json) =>
      _$SaveOrderModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SaveOrderModelToJson(this);
}

@JsonSerializable()
class Order {
  int? id;
  String? incrementId;
  // String? customerEmail;
  // String? customerFirstName;
  // String? customerLastName;

  Order({this.id});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
