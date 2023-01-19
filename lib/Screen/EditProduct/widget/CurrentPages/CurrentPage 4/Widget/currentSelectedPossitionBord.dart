import 'package:flutter/material.dart';
import '../../../../../../Helper/Color.dart';
import '../../../../../../Widget/validation.dart';
import '../../../../EditProduct.dart';

currentSelectedPossitionBord(
  BuildContext context,
  Function update,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            editProvider!.curSelPos = 0;
            update();
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: editProvider!.curSelPos == 0
                  ? primary
                  : const Color(0xfff5f5f5),
            ),
            child: Center(
              child: Text(
                getTranslated(context, "General Information")!,
                style: TextStyle(
                  color: editProvider!.curSelPos == 0 ? white : black,
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
            editProvider!.curSelPos = 1;
            update();
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: editProvider!.curSelPos == 1
                  ? primary
                  : const Color(0xfff5f5f5),
            ),
            child: Center(
              child: Text(
                getTranslated(context, "Attributes")!,
                style: TextStyle(
                  color: editProvider!.curSelPos == 1 ? white : black,
                ),
              ),
            ),
          ),
        ),
      ),
      editProvider!.productType == 'variable_product'
          ? Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  editProvider!.curSelPos = 2;
                  update();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: editProvider!.curSelPos == 2
                        ? primary
                        : const Color(0xfff5f5f5),
                  ),
                  child: Center(
                    child: Text(
                      getTranslated(context, "Variations")!,
                      style: TextStyle(
                        color: editProvider!.curSelPos == 2 ? white : black,
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
