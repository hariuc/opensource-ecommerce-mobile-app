/*
 *   Webkul Software.
 *   @package Mobikul Application Code.
 *   @Category Mobikul
 *   @author Webkul <support@webkul.com>
 *   @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *   @license https://store.webkul.com/license.html
 *   @link https://store.webkul.com/license.html
 */

// ignore_for_file: file_names

abstract class SaveOrderBaseEvent{}


class SaveOrderFetchDataEvent extends SaveOrderBaseEvent{
  Map<String, dynamic>? serverPayload;
  SaveOrderFetchDataEvent({this.serverPayload});
}