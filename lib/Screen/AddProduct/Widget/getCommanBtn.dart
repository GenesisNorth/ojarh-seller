// upload button :-
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Widget/ProductDescription.dart';
import '../../../Widget/snackbar.dart';
import '../../../Widget/validation.dart';
import '../../MediaUpload/Media.dart';
import '../Add_Product.dart';

getCommonButtonAdd(
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
            builder: (context) =>
                const Media(from: "main", type: "add", pos: -1),
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
              type: "add",
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
                ProductDescription(addProvider!.description ?? "",false),
          ),
        ).then((changed) {
          addProvider!.description = changed;
        });
      }else if (index == 7) {
        Navigator.push(
          context,
          CupertinoPageRoute<String>(
            builder: (context) =>
                ProductDescription(addProvider!.sortDescription ?? "", true),
          ),
        ).then((changed) {
          addProvider!.sortDescription = changed;
        });
      }
       else if (index == 4) {
        if (addProvider!.simpleProductPriceController.text.isEmpty) {
          setSnackbar(
            getTranslated(context, "Please enter product price")!,
            context,
          );
        } else if (addProvider!.simpleProductSpecialPriceController.text.isEmpty) {
          addProvider!.simpleProductSaveSettings = true;
          setSnackbar(
            getTranslated(context, "Setting saved successfully")!,
            context,
          );
          setState();
        } else if (int.parse(addProvider!.simpleproductPrice!) <
            int.parse(addProvider!.simpleproductSpecialPrice!)) {
          setSnackbar(
            getTranslated(
                context, "Special price must be less than original price")!,
            context,
          );
        } else {
          addProvider!.simpleProductSaveSettings = true;
          setSnackbar(
            getTranslated(context, "Setting saved successfully")!,
            context,
          );
          setState((){});
        }
      } else if (index == 5) {
        if (addProvider!.isStockSelected != null &&
            addProvider!.isStockSelected == true &&
            (addProvider!.variountProductTotalStock.text.isEmpty ||
                addProvider!.stockStatus.isEmpty)) {
          setSnackbar(
            getTranslated(context, "Please enter all details")!,
            context,
          );
        } else {
          addProvider!.variantProductProductLevelSaveSettings = true;
          setSnackbar(
              getTranslated(context, "Setting saved successfully")!, context);
          setState(() {});
        }
      } else if (index == 6) {
        addProvider!.variantProductVariableLevelSaveSettings = true;
        setSnackbar(
          getTranslated(context, "Setting saved successfully")!,
          context,
        );
        setState(() {});
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

uploadedOtherImageShow(Function setState) {
  return addProvider!.otherImageUrl.isEmpty
      ? Container()
      : SizedBox(
          width: double.infinity,
          height: 130,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: addProvider!.otherPhotos.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        right: 8.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          addProvider!.otherImageUrl[i],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        addProvider!.otherPhotos.removeAt(i);
                        addProvider!.otherImageUrl.removeAt(i);
                        setState();
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primary,
                        ),
                        child: const Icon(
                          Icons.clear,
                          size: 15,
                          color: white,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
}
