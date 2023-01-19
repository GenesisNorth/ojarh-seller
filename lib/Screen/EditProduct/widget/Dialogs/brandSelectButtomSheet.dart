import 'package:flutter/material.dart';
import 'package:sellermultivendor/Widget/validation.dart';
import '../../../../Helper/Color.dart';
import '../../../../Model/BrandModel/brandModel.dart';
import '../../../../Provider/settingProvider.dart';
import '../../EditProduct.dart';

brandSelectButtomSheet(
  BuildContext context,
  Function update,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.arrow_back),
                      Text(
                        getTranslated(context, "Select Brand")!,
                      ),
                      Container(width: 2),
                    ],
                  ),
                ),
                Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 5, start: 10, end: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: editProvider!.brandList.length,
                    itemBuilder: (context, index) {
                      BrandModel? item;

                      item = editProvider!.brandList.isEmpty
                          ? null
                          : editProvider!.brandList[index];

                      return item == null
                          ? Container()
                          : getbrands(index, context, update);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

getbrands(int index, BuildContext context, Function update) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            editProvider!.selectedBrandName =
                editProvider!.brandList[index].name;
            editProvider!.selectedBrandId = editProvider!.brandList[index].id;
            update();
          },
          child: Column(
            children: [
              const Divider(),
              Row(
                children: [
                  editProvider!.selectedBrandId ==
                          editProvider!.brandList[index].id
                      ? Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                            color: grey2,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: const BoxDecoration(
                                color: primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                            color: grey2,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: const BoxDecoration(
                                color: white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: width * 0.6,
                    child: Text(
                      editProvider!.brandList[index].name!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ],
    ),
  );
}
