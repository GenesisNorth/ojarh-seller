import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellermultivendor/Helper/Color.dart';
import 'package:sellermultivendor/Widget/parameterString.dart';
import '../../Helper/ApiBaseHelper.dart';
import '../../Model/BrandModel/brandModel.dart';
import '../../Provider/addProductProvider.dart';
import '../../Provider/attributeSetProvider.dart';
import '../../Provider/categoryProvider.dart';
import '../../Provider/countryProvider.dart';
import '../../Provider/settingProvider.dart';
import '../../Provider/taxProvider.dart';
import '../../Provider/zipcodeProvider.dart';
import '../../Widget/api.dart';
import '../../Widget/desing.dart';
import '../../Widget/networkAvailablity.dart';
import '../../Widget/sharedPreferances.dart';
import '../../Widget/snackbar.dart';
import '../../Widget/validation.dart';
import 'Widget/CurrentPages/currentPage1.dart';
import 'Widget/CurrentPages/currentPage2.dart';
import 'Widget/CurrentPages/currentPage3.dart';
import 'Widget/CurrentPages/Current Page 4/currentPage4.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

late int max;
late int col;

AddProductProvider? addProvider;

class _AddProductState extends State<AddProduct> with TickerProviderStateMixin {
//------------------------------------------------------------------------------
//========================= For Form Validation ================================

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//------------------------------------------------------------------------------
//========================= For Animation ======================================

  Future<void> _playAnimation() async {
    try {
      await addProvider!.buttonController!.forward();
    } on TickerCanceled {}
  }

//------------------------------------------------------------------------------
//========================= InIt MEthod ========================================
  @override
  void initState() {
    addProvider = Provider.of<AddProductProvider>(context, listen: false);
    addProvider!.freshInitializationOfAddProduct();
    addProvider!.productImage = "";
    addProvider!.productImageUrl = "";
    addProvider!.uploadedVideoName = "";
    addProvider!.cityScrollController.addListener(_scrollListener);
    getAllData();

    addProvider!.buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    addProvider!.productImage = '';
    addProvider!.productImageUrl = '';
    addProvider!.uploadedVideoName = '';
    addProvider!.otherPhotos = [];
    addProvider!.otherImageUrl = [];
    addProvider!.buttonSqueezeanimation = Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: addProvider!.buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
    super.initState();
  }

  brandSelectButtomSheet() {
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
                      itemCount: addProvider!.brandList.length,
                      itemBuilder: (context, index) {
                        BrandModel? item;

                        item = addProvider!.brandList.isEmpty
                            ? null
                            : addProvider!.brandList[index];

                        return item == null ? Container() : getbrands(index);
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

  getbrands(int index) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              addProvider!.selectedBrandName =
                  addProvider!.brandList[index].name;
              addProvider!.selectedBrandId = addProvider!.brandList[index].id;
              setState(() {});
            },
            child: Column(
              children: [
                const Divider(),
                Row(
                  children: [
                    addProvider!.selectedBrandId ==
                            addProvider!.brandList[index].id
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
                        addProvider!.brandList[index].name!,
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

  Future<void> getBrands() async {
    context.read<SettingProvider>().CUR_USERID = await getPrefrence(Id);
    var parameter = {
      SellerId: context.read<SettingProvider>().CUR_USERID,
    };
    ApiBaseHelper().postAPICall(getBrandsDataApi, parameter).then(
      (getdata) async {
        bool error = getdata["error"];
        String? msg = getdata["message"];

        if (!error) {
          addProvider!.brandList.clear();
          var data = getdata["data"];
          addProvider!.brandList =
              (data as List).map((data) => BrandModel.fromJson(data)).toList();
        } else {
          setSnackbar(
            msg!,
            context,
          );
        }
      },
      onError: (error) {
        setSnackbar(
          error.toString(),
          context,
        );
      },
    );
  }

  getAllData() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      getBrands();

      //get Country
      await context.read<CountryProvider>().setCountrys(false, true).then(
        (value) {
          if (value == true) {
            setSnackbar(context.read<CountryProvider>().errorMessage, context);
          }
        },
      );
      if (mounted && addProvider!.cityState != null) {
        if (mounted) {
          setState(() {});
        }
      }

      //get zipCode
      await context.read<ZipcodeProvider>().setZipCode(true).then(
        (value) {
          if (value == true) {
            setSnackbar(context.read<ZipcodeProvider>().errorMessage, context);
          }
        },
      );
      // get tax
      await context.read<TaxProvider>().setTax(true).then(
        (value) {
          if (value == true) {
            setSnackbar(context.read<TaxProvider>().errorMessage, context);
          }
        },
      );
      // get category
      await context
          .read<CategoryProvider>()
          .setCategory(
            true,
            context,
          )
          .then(
        (value) {
          if (value == true) {
            setSnackbar(context.read<CategoryProvider>().errorMessage, context);
          }
        },
      );
      // get attribute set
      await context.read<AttributeProvider>().setAttributeSet(true).then(
        (value) {
          if (value == true) {
            setSnackbar(
                context.read<AttributeProvider>().errorMessage, context);
          }
        },
      );
      // get attribute
      await context.read<AttributeProvider>().setAttributes(true).then(
        (value) {
          if (value == true) {
            setSnackbar(
                context.read<AttributeProvider>().errorMessage, context);
          }
        },
      );
      // get attribute value
      await context.read<AttributeProvider>().setAttributesValue(true).then(
        (value) {
          if (value == true) {
            setSnackbar(
                context.read<AttributeProvider>().errorMessage, context);
          }
        },
      );
      setState(
        () {},
      );
    } else {
      setState(
        () {
          isNetworkAvail = false;
        },
      );
    }
  }

  _scrollListener() async {
    if (addProvider!.cityScrollController.offset >=
            addProvider!.cityScrollController.position.maxScrollExtent &&
        !addProvider!.cityScrollController.position.outOfRange) {
      if (mounted) {
        setState(() {});

        addProvider!.cityState!(() {
          addProvider!.isLoadingMoreCity = true;
          addProvider!.isProgress = true;
        });

        //get Country
        await context
            .read<CountryProvider>()
            .setCountrys(false, true)
            .then((value) {
          if (value == true) {
            setSnackbar(context.read<CountryProvider>().errorMessage, context);
          }
        });
        if (mounted && addProvider!.cityState != null) {
          addProvider!.cityState!(() {});
        }
        if (mounted) setState(() {});
      }
    }
  }

//------------------------------------------------------------------------------
//========================= Video Type =========================================

  videoUrlEnterField(String hinttitle) {
    return Container(
      height: 65,
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(addProvider!.vidioTypeFocus);
        },
        keyboardType: TextInputType.text,
        controller: addProvider!.vidioTypeController,
        style: const TextStyle(
          color: fontColor,
          fontWeight: FontWeight.normal,
        ),
        focusNode: addProvider!.vidioTypeFocus,
        textInputAction: TextInputAction.next,
        onChanged: (String? value) {
          addProvider!.videoUrl = value;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: lightWhite,
          hintText: hinttitle,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 40, maxHeight: 20),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: fontColor),
            borderRadius: BorderRadius.circular(7.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: lightWhite),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  update() {
    setState(
      () {},
    );
  }

  updateCountry() async {
    await context.read<CountryProvider>().setCountrys(true, true).then(
      (value) {
        if (value == true) {
          setSnackbar(context.read<CountryProvider>().errorMessage, context);
        }
      },
    );
    if (mounted && addProvider!.cityState != null) {
      addProvider!.cityState!(() {});
    }
    if (mounted) setState(() {});
  }

//==============================================================================
//=========================== Body Part ========================================

  getBodyPart() {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 25.0,
                  bottom: 20,
                  right: 20.0,
                  left: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addProvider!.currentPage == 1
                        ? currentPage1(context, update, updateCountry)
                        : Container(),
                    addProvider!.currentPage == 2
                        ? currentPage2(context, update, updateCountry)
                        : Container(),
                    addProvider!.currentPage == 3
                        ? currentPage3(context, update, updateCountry)
                        : Container(),
                    addProvider!.currentPage == 4
                        ? currentPage4(context, setState, updateCountry)
                        : Container(),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
          ),
          getButtomBarButton(),
        ],
      ),
    );
  }

  getButtomBarButton() {
    return Positioned.directional(
      bottom: 0.0,
      textDirection: Directionality.of(context),
      child: Container(
        width: width,
        height: 60,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              addProvider!.currentPage != 1
                  ? Expanded(
                      child: InkWell(
                        onTap: () {
                          if (addProvider!.currentPage == 1) {
                          } else if (addProvider!.currentPage == 2) {
                            addProvider!.setCurrentPageValue(1);
                          } else if (addProvider!.currentPage == 3) {
                            addProvider!.setCurrentPageValue(2);
                          } else if (addProvider!.currentPage == 4) {
                            addProvider!.setCurrentPageValue(3);
                          }
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: lightWhite1,
                          ),
                          height: 56,
                          child: Center(
                            child: Text(
                              getTranslated(context, "Back")!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    if (addProvider!.currentPage == 1) {
                      if (addProvider!.productName == null) {
                        setSnackbar(
                          getTranslated(context, "Please select product Name")!,
                          context,
                        );
                      } else if (addProvider!.hsnCode == null) {
                        setSnackbar(
                          getTranslated(context, 'Please Add HSN Code')!,
                          context,
                        );
                      } else if (addProvider!.sortDescription == null) {
                        setSnackbar(
                          getTranslated(
                              context, "Please Add Sort Description")!,
                          context,
                        );
                      } else {
                        addProvider!.setCurrentPageValue(2);
                        setState(() {});
                      }
                    } else if (addProvider!.currentPage == 2) {
                      if (addProvider!.minOrderQuantity == null) {
                        setSnackbar(
                          getTranslated(
                              context, "Please Add minimam Order Quantity")!,
                          context,
                        );
                      } else if (addProvider!.quantityStepSize == null) {
                        setSnackbar(
                          getTranslated(
                              context, "Please Add Quantity Step Size")!,
                          context,
                        );
                      } else if (addProvider!.isCancelable == "1" &&
                          addProvider!.tillwhichstatus == null) {
                        setSnackbar(
                          getTranslated(
                              context, "Please Add Till Which Status")!,
                          context,
                        );
                      } else if (addProvider!.selectedCatID == null) {
                        setSnackbar(
                          getTranslated(context, "Please select category")!,
                          context,
                        );
                      } else {
                        addProvider!.setCurrentPageValue(3);

                        setState(() {});
                      }
                    } else if (addProvider!.currentPage == 3) {
                      if (addProvider!.productImage == "") {
                        setSnackbar(
                          getTranslated(
                              context, "Please Add Product Main Image")!,
                          context,
                        );
                      } else if ((addProvider!.description == '' ||
                          addProvider!.description == null)) {
                        setSnackbar(
                          getTranslated(context, "Please Add Description")!,
                          context,
                        );
                      } else {
                        addProvider!.setCurrentPageValue(4);

                        setState(() {});
                      }
                    } else if (addProvider!.currentPage == 4) {
                      validateAndSubmit();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: primary,
                    ),
                    height: 56,
                    child: Center(
                      child: Text(
                        addProvider!.currentPage != 4
                            ? getTranslated(context, "Next")!
                            : getTranslated(context, "Add Product")!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//==============================================================================
  void validateAndSubmit() async {
    List<String> attributeIds = [];
    List<String> attributesValuesIds = [];

    for (var i = 0; i < addProvider!.variationBoolList.length; i++) {
      if (addProvider!.variationBoolList[i]) {
        final attributes = addProvider!.attributesList
            .where((element) =>
                element.name == addProvider!.attrController[i].text)
            .toList();
        if (attributes.isNotEmpty) {
          attributeIds.add(attributes.first.id!);
        }
      }
    }
    for (var key in attributeIds) {
      for (var element in addProvider!.selectedAttributeValues[key]!) {
        attributesValuesIds.add(element.id!);
      }
    }
    if (validateAndSave()) {
      _playAnimation();
      addProvider!.addProductAPI(attributesValuesIds, context, update);
    }
  }

  bool validateAndSave() {
    final form = _formkey.currentState!;
    form.save();
    if (form.validate()) {
      if (addProvider!.productType == null) {
        setSnackbar(
          getTranslated(context, "Please select product type")!,
          context,
        );
        return false;
      } else if (addProvider!.description == '' &&
          addProvider!.description == null) {
        setSnackbar(
          getTranslated(context, "Please Add Description")!,
          context,
        );
        return false;
      } else if (addProvider!.productImage == '' &&
          addProvider!.mainImageProductImage == "") {
        setSnackbar(
          getTranslated(context, "Please Add product image")!,
          context,
        );
        return false;
      } else if (addProvider!.selectedCatID == null) {
        setSnackbar(
          getTranslated(context, "Please select category")!,
          context,
        );
        return false;
      } else if (addProvider!.selectedTypeOfVideo != null &&
          addProvider!.videoUrl == null) {
        setSnackbar(
          getTranslated(context, "Please enter video url")!,
          context,
        );
        return false;
      } else if (addProvider!.productType == 'simple_product') {
        if (addProvider!.simpleProductPriceController.text.isEmpty) {
          setSnackbar(
            getTranslated(context, "Please enter product price")!,
            context,
          );
          return false;
        } else if (addProvider!.simpleProductPriceController.text.isNotEmpty &&
            addProvider!.simpleProductSpecialPriceController.text.isNotEmpty &&
            double.parse(
                    addProvider!.simpleProductSpecialPriceController.text) >
                double.parse(addProvider!.simpleProductPriceController.text)) {
          setSnackbar(
            getTranslated(context, "Special price can not greater than price")!,
            context,
          );
          return false;
        } else if (addProvider!.isStockSelected != null &&
            addProvider!.isStockSelected == true) {
          if (addProvider!.simpleproductSKU == null ||
              addProvider!.simpleproductTotalStock == null) {
            setSnackbar(
              getTranslated(context, "Please enter stock details")!,
              context,
            );
            return false;
          }
          return true;
        }
        return true;
      } else if (addProvider!.productType == 'variable_product') {
        for (int i = 0; i < addProvider!.variationList.length; i++) {
          if (addProvider!.variationList[i].price == null ||
              addProvider!.variationList[i].price!.isEmpty) {
            setSnackbar(
              getTranslated(context, "Please enter price details")!,
              context,
            );
            return false;
          }
        }
        if (addProvider!.isStockSelected != null &&
            addProvider!.isStockSelected == true) {
          if (addProvider!.variantStockLevelType == "product_level" &&
              (addProvider!.variantproductSKU == null ||
                  addProvider!.variantproductTotalStock == null)) {
            setSnackbar(
              getTranslated(context, "Please enter stock details")!,
              context,
            );
            return false;
          }

          if (addProvider!.variantStockLevelType == "variable_level") {
            for (int i = 0; i < addProvider!.variationList.length; i++) {
              if (addProvider!.variationList[i].sku == null ||
                  addProvider!.variationList[i].sku!.isEmpty ||
                  addProvider!.variationList[i].stock == null ||
                  addProvider!.variationList[i].stock!.isEmpty) {
                setSnackbar(
                  getTranslated(context, "Please enter stock details")!,
                  context,
                );
                return false;
              }
            }
            return true;
          }
          return true;
        }
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    addProvider = Provider.of<AddProductProvider>(context, listen: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: white,
        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: DesignConfiguration.shadow(),
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () => Navigator.of(context).pop(),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: black,
                    size: 25,
                  ),
                ),
              ),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              getTranslated(context, "Add New Product")!,
              style: const TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: width * 0.1),
            Text(
              "${getTranslated(context, "Step")!} ${addProvider!.currentPage} ${getTranslated(context, "of")!} 4",
              style: const TextStyle(
                color: grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: getBodyPart(),
    );
  }
}
