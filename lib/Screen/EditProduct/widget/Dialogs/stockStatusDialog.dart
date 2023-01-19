import 'package:flutter/material.dart';
import '../../../../Helper/Color.dart';
import '../../../../Widget/validation.dart';
import '../../EditProduct.dart';

stockStatusDialog(
  BuildContext context,
  Function update,
) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          editProvider!.taxesState = setStater;
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslated(context, "Select Type")!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: fontColor),
                      ),
                    ],
                  ),
                ),
                const Divider(color: lightBlack),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            editProvider!.simpleproductStockStatus = '1';
                            Navigator.of(context).pop();

                            update();
                          },
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 20.0, 20.0, 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getTranslated(context, "In Stock")!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            editProvider!.simpleproductStockStatus = '0';
                            Navigator.of(context).pop();

                            update();
                          },
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 20.0, 20.0, 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getTranslated(context, "Out Of Stock")!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
