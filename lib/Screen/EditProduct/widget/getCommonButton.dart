// upload button :-

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Widget/ProductDescription.dart';
import '../../../Widget/snackbar.dart';
import '../../../Widget/validation.dart';
import '../../MediaUpload/Media.dart';
import '../EditProduct.dart';

getCommonButton(
  String title,
  int index,
  Function setState,
  BuildContext context,
) {
  return InkWell(
    onTap: () {
      if (index == 1) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const Media(
              from: "main",
              type: "edit",
              pos: 0,
            ),
          ),
        ).then(
          (value) => setState(),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const Media(
              from: "other",
              pos: 0,
              type: "edit",
            ),
          ),
        ).then(
          (value) => setState(),
        );
      } else if (index == 3) {
        Navigator.push(
          context,
          CupertinoPageRoute<String>(
            builder: (context) =>
                ProductDescription(editProvider!.description ?? "",false),
          ),
        ).then((changed) {
          editProvider!.description = changed;
        });
      } else if (index == 7) {
        Navigator.push(
          context,
          CupertinoPageRoute<String>(
            builder: (context) =>
                ProductDescription(editProvider!.sortDescription ?? "",true),
          ),
        ).then((changed) {
          editProvider!.sortDescription = changed;
        });
      } else if (index == 4) {
        if (editProvider!.simpleProductPriceController.text.isEmpty) {
          setSnackbar(
            getTranslated(context, "Please enter product price")!,
            context,
          );
        } else if (editProvider!
            .simpleProductSpecialPriceController.text.isEmpty) {
          editProvider!.simpleProductSaveSettings = true;
          setSnackbar(
            getTranslated(context, "Setting saved successfully")!,
            context,
          );
          setState(() {});
        } else if (int.parse(editProvider!.simpleproductPrice!) <
            int.parse(editProvider!.simpleproductSpecialPrice!)) {
          setSnackbar(
            getTranslated(
                context, "Special price must be less than original price")!,
            context,
          );
        } else {
          editProvider!.simpleProductSaveSettings = true;
          setSnackbar(
            getTranslated(context, "Setting saved successfully")!,
            context,
          );
          setState();
        }
      } else if (index == 5) {
        if (editProvider!.isStockSelected != null &&
            editProvider!.isStockSelected == true &&
            (editProvider!.variountProductTotalStock.text.isEmpty ||
                editProvider!.stockStatus.isEmpty)) {
          setSnackbar(
            getTranslated(context, "Please enter all details")!,
            context,
          );
        } else {
          editProvider!.variantProductProductLevelSaveSettings = true;
          setSnackbar(
              getTranslated(context, "Setting saved successfully")!, context);
          setState();
        }
      } else if (index == 6) {
        editProvider!.variantProductVariableLevelSaveSettings = true;
        setSnackbar(
          getTranslated(context, "Setting saved successfully")!,
          context,
        );
        setState();
      }
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: primary,
      ),
      height: 35,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
