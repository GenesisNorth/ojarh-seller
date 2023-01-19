//------------------------------------------------------------------------------
//=================================== Made In ==================================

import 'package:flutter/material.dart';
import 'package:sellermultivendor/Widget/desing.dart';
import '../../../../Helper/Color.dart';
import '../../../../Widget/validation.dart';
import '../../Add_Product.dart';

cityDialog(BuildContext context, Function setState, Function updateCity) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          addProvider!.cityState = setStater;

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
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                  child: Text(
                    getTranslated(context, "Made In")!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: fontColor),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: addProvider!.cityController,
                          autofocus: false,
                          style: const TextStyle(
                            color: fontColor,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                            hintText: getTranslated(context, 'SEARCH_LBL'),
                            hintStyle:
                                TextStyle(color: primary.withOpacity(0.5)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                        onPressed: () async {
                          addProvider!.isLoadingMoreCity = true;
                          setStater;
                          updateCity();
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                addProvider!.cityLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : (addProvider!.citySearchLIst.isNotEmpty)
                        ? Flexible(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: SingleChildScrollView(
                                controller: addProvider!.cityScrollController,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              getCityList(setState, context),
                                        ),
                                        Center(
                                          child: DesignConfiguration
                                              .showCircularProgress(
                                            addProvider!.isLoadingMoreCity!,
                                            primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    DesignConfiguration.showCircularProgress(
                                      addProvider!.isProgress,
                                      primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: DesignConfiguration.getNoItem(context),
                          )
              ],
            ),
          );
        },
      );
    },
  );
}

getCityList(Function setState, BuildContext context) {
  return addProvider!.citySearchLIst
      .asMap()
      .map(
        (index, element) => MapEntry(
          index,
          InkWell(
            onTap: () {
              addProvider!.madeIn = addProvider!.citySearchLIst[index].name;

              addProvider!.selCityPos = index;

              Navigator.of(context).pop();
              setState;
              addProvider!.city =
                  addProvider!.citySearchLIst[addProvider!.selCityPos!].id;
            },
            child: SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  addProvider!.citySearchLIst[index].name!,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
          ),
        ),
      )
      .values
      .toList();
}
