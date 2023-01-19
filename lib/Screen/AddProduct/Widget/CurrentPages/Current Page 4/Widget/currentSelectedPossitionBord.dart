import 'package:flutter/material.dart';
import '../../../../../../Helper/Color.dart';
import '../../../../../../Widget/validation.dart';
import '../../../../Add_Product.dart';

currentSelectedPossitionBord(
  BuildContext context,
  Function setState,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            addProvider!.curSelPos = 0;
            setState(() {});
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: addProvider!.curSelPos == 0
                  ? primary
                  : const Color(0xfff5f5f5),
            ),
            child: Center(
              child: Text(
                getTranslated(context, "General Information")!,
                style: TextStyle(
                  color: addProvider!.curSelPos == 0 ? white : black,
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            addProvider!.curSelPos = 1;
            setState((){});
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: addProvider!.curSelPos == 1
                  ? primary
                  : const Color(0xfff5f5f5),
            ),
            child: Center(
              child: Text(
                getTranslated(context, "Attributes")!,
                style: TextStyle(
                  color: addProvider!.curSelPos == 1 ? white : black,
                ),
              ),
            ),
          ),
        ),
      ),
      addProvider!.productType == 'variable_product'
          ? Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  addProvider!.curSelPos = 2;
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: addProvider!.curSelPos == 2
                        ? primary
                        : const Color(0xfff5f5f5),
                  ),
                  child: Center(
                    child: Text(
                      getTranslated(context, "Variations")!,
                      style: TextStyle(
                        color: addProvider!.curSelPos == 2 ? white : black,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Container(),
    ],
  );
}
