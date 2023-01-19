import 'package:flutter/material.dart';
import '../../../../../../Widget/validation.dart';
import '../../../../Add_Product.dart';
import '../../../getCommanBtn.dart';
import '../../../getCommanInputTextFieldWidget.dart';
import '../../../getCommanWidget.dart';
import '../../../getIconSelectionDesingWidget.dart';

selectionPossitionZero(
  BuildContext context,
  Function setState,
  Function updateCity,
) {
  return addProvider!.curSelPos == 0
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCommanSizedBox(),
            getPrimaryCommanText(
                getTranslated(context, "Type Of Product")!, false),
            getCommanSizedBox(),

            getIconSelectionDesing(getTranslated(context, "Select Type")!, 9,
                context, setState, updateCity),
            addProvider!.productType == 'simple_product'
                ? getCommanSizedBox()
                : Container(),
            addProvider!.productType == 'simple_product'
                ? getCommanSizedBox()
                : Container(),
            addProvider!.productType == 'simple_product'
                ? Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: getPrimaryCommanText(
                            getTranslated(context, "PRICE_LBL")!, true),
                      ),
                      Expanded(
                        flex: 3,
                        child: getCommanInputTextField(
                          //logic painding
                          " ",
                          10,
                          0.06,
                          1,
                          3, context,
                        ),
                      ),
                    ],
                  )
                : Container(),
            // For Simple Product

            addProvider!.productType == 'simple_product'
                ? getCommanSizedBox()
                : Container(),

            addProvider!.productType == 'simple_product'
                ? Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: getPrimaryCommanText(
                            getTranslated(context, "Special Price")!, true),
                      ),
                      Expanded(
                        flex: 3,
                        child: getCommanInputTextField(
                          " ",
                          11,
                          0.06,
                          1,
                          3,
                          context,
                        ),
                      ),
                    ],
                  )
                : Container(),
            addProvider!.productType == 'simple_product'
                ? getCommanSizedBox()
                : Container(),
            addProvider!.productType == 'simple_product'
                ? Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: getPrimaryCommanText(
                            getTranslated(context, "Enable Stock Management")!,
                            true),
                      ),
                      Expanded(
                        flex: 2,
                        child: CheckboxListTile(
                          value: addProvider!.isStockSelected ?? false,
                          onChanged: (bool? value) {
                            addProvider!.isStockSelected = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),

            addProvider!.productType == 'variable_product'
                ? Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: getPrimaryCommanText(
                            getTranslated(context, "Enable Stock Management")!,
                            true),
                      ),
                      Expanded(
                        flex: 2,
                        child: CheckboxListTile(
                          value: addProvider!.isStockSelected ?? false,
                          onChanged: (bool? value) {
                            addProvider!.isStockSelected = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),

            addProvider!.isStockSelected != null &&
                    addProvider!.isStockSelected == true &&
                    addProvider!.productType == 'simple_product'
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: getPrimaryCommanText(
                                getTranslated(context, "SKU")!, true),
                          ),
                          Expanded(
                            flex: 3,
                            child: getCommanInputTextField(
                              " ",
                              12,
                              0.06,
                              1,
                              2,
                              context,
                            ),
                          ),
                        ],
                      ),
                      getCommanSizedBox(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: getPrimaryCommanText(
                                getTranslated(context, "Total Stock")!, true),
                          ),
                          Expanded(
                            flex: 3,
                            child: getCommanInputTextField(
                              " ",
                              13,
                              0.06,
                              1,
                              3,
                              context,
                            ),
                          ),
                        ],
                      ),
                      getCommanSizedBox(),
                      getIconSelectionDesing(
                          getTranslated(context, "Select Stock Status")!,
                          10,
                          context,
                          setState,
                          updateCity),
                    ],
                  )
                : Container(),

            addProvider!.productType == 'simple_product'
                ? getCommanSizedBox()
                : Container(),
            addProvider!.productType == 'simple_product'
                ? getCommanSizedBox()
                : Container(),
            addProvider!.productType == 'simple_product'
                ? getCommonButtonAdd(getTranslated(context, "Save Settings")!,
                    4, setState, context)
                : Container(),

            // varible product
            addProvider!.isStockSelected != null &&
                    addProvider!.isStockSelected == true &&
                    addProvider!.productType == 'variable_product'
                ? getPrimaryCommanText(
                    getTranslated(context, "Choose Stock Management Type")!,
                    false)
                : Container(),
            addProvider!.productType == 'variable_product'
                ? getCommanSizedBox()
                : Container(),
            addProvider!.isStockSelected != null &&
                    addProvider!.isStockSelected == true &&
                    addProvider!.productType == 'variable_product'
                ? getIconSelectionDesing(
                    getTranslated(context, "Select Stock Status")!,
                    11,
                    context,
                    setState,
                    updateCity)
                : Container(),
              addProvider!.productType == 'variable_product' &&
                    addProvider!.variantStockLevelType == "product_level" &&
                    addProvider!.isStockSelected != null &&
                    addProvider!.isStockSelected == true
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCommanSizedBox(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: getPrimaryCommanText(
                                getTranslated(context, "SKU")!, true),
                          ),
                          Expanded(
                            flex: 3,
                            child: getCommanInputTextField(
                              " ",
                              14,
                              0.06,
                              1,
                              2,
                              context,
                            ),
                          ),
                        ],
                      ),

                      getCommanSizedBox(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: getPrimaryCommanText(
                                getTranslated(context, "Total Stock")!, true),
                          ),
                          Expanded(
                            flex: 3,
                            child: getCommanInputTextField(
                              " ",
                              15,
                              0.06,
                              1,
                              3,
                              context,
                            ),
                          ),
                        ],
                      ),
                      getPrimaryCommanText("Stock Status", false),
                      getCommanSizedBox(),
                      getIconSelectionDesing(
                          getTranslated(context, "Select Stock Status")!,
                          12,
                          context,
                          setState,
                          updateCity),
                    ],
                  )
                : Container(),
            getCommanSizedBox(),
            getCommanSizedBox(),

            addProvider!.productType == 'variable_product' &&
                    addProvider!.variantStockLevelType == "product_level"
                ? getCommonButtonAdd(getTranslated(context, "Save Settings")!,
                    5, setState, context)
                : Container(),

            addProvider!.productType == 'variable_product' &&
                    addProvider!.variantStockLevelType == "variable_level"
                ? getCommonButtonAdd(getTranslated(context, "Save Settings")!,
                    6, setState, context)
                : Container(),
          ],
        )
      : Container();
}
