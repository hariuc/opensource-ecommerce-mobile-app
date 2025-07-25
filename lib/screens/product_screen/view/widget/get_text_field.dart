
/*
 *   Webkul Software.
 *   @package Mobikul Application Code.
 *   @Category Mobikul
 *   @author Webkul <support@webkul.com>
 *   @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *   @license https://store.webkul.com/license.html
 *   @link https://store.webkul.com/license.html
 */

import '../../../../data_model/product_model/product_screen_model.dart';
import 'package:bagisto_app_demo/screens/product_screen/utils/index.dart';


class GetTextField extends StatefulWidget {
  final Attributes? variation;
  final int  index;
  final List optionArray;
  final Function(List, String)? callback;
  final List<Attributes>? customOptions;
  final NewProducts? productData;
  const GetTextField({Key? key, this.variation, required this.index, required this.optionArray,this.callback,this.productData,this.customOptions}) : super(key: key);

  @override
  State<GetTextField> createState() => _GetTextFieldState();
}

class _GetTextFieldState extends State<GetTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropDownType(
                variation: widget.variation,
                options: _getOptions(widget.index),
                callback: (id) {
                  setState(() {
                    var firstAdd = true;
                    Map<String, dynamic> optionData = {};
                    optionData["attributeId"] = widget.variation?.id?.toString() ?? '';
                    optionData["attributeOptionId"] = id;
                    if (widget.optionArray.isNotEmpty) {
                      for (var optionArrayKey = 0;
                      optionArrayKey < widget.optionArray.length;
                      optionArrayKey++) {
                        if (widget.optionArray[optionArrayKey]["attributeId"]
                            .toString() ==
                            optionData["attributeId"].toString()) {
                          if (widget.optionArray[optionArrayKey]["attributeOptionId"]
                              .toString() !=
                              id.toString()) {
                            widget.optionArray[optionArrayKey]["attributeOptionId"] =
                                id;
                            firstAdd = false;
                            break;
                          } else {
                            firstAdd = false;
                            break;
                          }
                        } else {
                          firstAdd = true;
                        }
                      }
                      if (firstAdd) {
                        widget.optionArray.add(optionData);
                      }
                    } else {
                      widget.optionArray.add(optionData);
                    }
                  });
                  _updateCallBack();
                })
          ],
        ));
  }

  _updateCallBack() {
    if (widget.callback != null) {
      Map<String, dynamic> dict = {};
      dict["superAttribute"] = widget.optionArray;
      widget.callback!(widget.optionArray, _getId());
    }
  }

  _getOptions(int index) {
    if ((widget.customOptions?.length ?? 0) > index) {
      if (index == 0) {
        var codeList = widget.customOptions?[0].options
            ?.map((element) => element.id)
            .toList();
        var options = widget.customOptions?[0].options
            ?.where((element) => codeList?.contains(element.id) ?? false);
        return options?.toList() ?? [];
      } else {
        var codeList =
        widget.customOptions?[index].options?.map((e) => e.id).toList();
        var options = widget.customOptions?[index].options
            ?.where((element) => codeList?.contains(element.id) ?? false);
        return options?.toList() ?? [];
      }
    }
    return [];
  }

  _getId() {
    String selectedProductAttributeId = "";
    var mappedKey = true;
    for (var optionArrayKey = 0;
    optionArrayKey < widget.optionArray.length;
    optionArrayKey++) {
      if (mappedKey) {
        loopIndexes:
        for (var index1 = 0;
        index1 < (widget.productData?.configurableData?.index?.length ?? 0);
        index1++) {
          for (var indexData = optionArrayKey;
          indexData <
              (widget.productData?.configurableData?.index?[index1]
                  .attributeOptionIds?.length ??
                  0);
          indexData++) {
            if (widget.optionArray[optionArrayKey]['attributeId'].toString() ==
                widget.productData?.configurableData?.index?[index1]
                    .attributeOptionIds?[indexData].attributeId
                    .toString() &&
                widget.optionArray[optionArrayKey]['attributeOptionId'].toString() ==
                    widget.productData?.configurableData?.index?[index1]
                        .attributeOptionIds?[indexData].attributeOptionId
                        .toString()) {
              mappedKey = true;
              selectedProductAttributeId =
                  widget.productData?.configurableData?.index?[index1].id ?? "";
              break loopIndexes;
            } else {
              mappedKey = false;
            }
          }
        }
      }
    }
    return selectedProductAttributeId;
  }
}
