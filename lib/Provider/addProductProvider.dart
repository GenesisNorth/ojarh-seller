import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellermultivendor/Provider/settingProvider.dart';
import '../Model/Attribute Models/AttributeModel/AttributesModel.dart';
import '../Model/Attribute Models/AttributeSetModel/AttributeSetModel.dart';
import '../Model/Attribute Models/AttributeValueModel/AttributeValue.dart';
import '../Model/BrandModel/brandModel.dart';
import '../Model/CategoryModel/categoryModel.dart';
import '../Model/ProductModel/Variants.dart';
import '../Model/TaxesModel/TaxesModel.dart';
import '../Model/ZipCodesModel/ZipCodeModel.dart';
import '../Model/city/cityModel.dart';
import '../Widget/api.dart';
import '../Widget/jwtkeySecurity.dart';
import '../Widget/networkAvailablity.dart';
import 'package:http/http.dart' as http;

import '../Widget/parameterString.dart';
import '../Widget/snackbar.dart';
import '../Widget/validation.dart';

enum AddProductStatus {
  initial,
  inProgress,
  isSuccsess,
  isFailure,
}

class AddProductProvider extends ChangeNotifier {
// update status

  AddProductStatus addProductStatus = AddProductStatus.initial;

  changeStatus(AddProductStatus status) {
    addProductStatus = status;
    notifyListeners();
  }

  freshInitializationOfAddProduct() {
    hsnCode = null;
    productName = null;
    sortDescription = null;
    tags = null;
    taxId = null;
    indicatorValue = null;
    madeIn = null;
    totalAllowQuantity = null;
    minOrderQuantity = null;
    quantityStepSize = null;
    warrantyPeriod = null;
    guaranteePeriod = null;
    deliverabletypeValue = "1";
    deliverableZipcodes = null;
    taxincludedinPrice = "0";
    isCODAllow = "0";
    isReturnable = "0";
    isCancelable = "0";
    tillwhichstatus = null;
    selectedCatName = null;
    selectedTaxID = null;
    isToggled = false;
    isreturnable = false;
    isCODallow = false;
    iscancelable = false;
    taxincludedInPrice = false;
    attributeIndiacator = 0;
    selCityPos = -1;
    city = null;
    cityState = null;
    isLoadingMoreCity = null;
    cityOffset = 0;
    cityLoading = true;
    citySearchLIst = [];
    isProgress = false;
    cityList = [];
    selectedTypeOfVideo = null;
    videoUrl = null;
    videoOfProduct = null;
    description = null;
    selectedCatID = null;
    productType = null;
    variantStockLevelType = "product_level";
    curSelPos = 0;
    simpleproductStockStatus = "1";
    simpleproductPrice = null;
    simpleproductSpecialPrice = null;
    simpleproductSKU = null;
    simpleproductTotalStock = null;
    variantStockStatus = "0";
    finalAttList = [];
    tempAttList = [];
    variantsIds = null;
    variantPrice = null;
    variantSpecialPrice = null;
    variantImages = null;
    variantproductSKU = null;
    variantproductTotalStock = null;
    stockStatus = '1';
    variantSku = null;
    variantTotalStock = null;
    variantLevelStockStatus = null;
    isStockSelected = null;
    simpleProductSaveSettings = false;
    variantProductProductLevelSaveSettings = false;
    variantProductVariableLevelSaveSettings = false;
    selectedBrandName = null;
    selectedBrandId = null;
    taxesList = [];
    attributeSetList = [];
    attributesList = [];
    attributesValueList = [];
    zipSearchList = [];
    catagorylist = [];
    variationBoolList = [];
    attrId = [];
    attrValId = [];
    attrVal = [];
    brandList = [];
    data = null;
    suggessionisNoData = false;
    mainImageProductImage = null;
    otherPhotos = [];
    otherPhotosFromGellery = [];
    otherImageUrl = [];
    variationList = [];
    currentPage = 1;
    productNameControlller.clear();
    sortDescriptionControlller.clear();
    tagsControlller.clear();
    totalAllowController.clear();
    minOrderQuantityControlller.clear();
    quantityStepSizeControlller.clear();
    madeInControlller.clear();
    warrantyPeriodController.clear();
    guaranteePeriodController.clear();
    vidioTypeController.clear();
    simpleProductPriceController.clear();
    simpleProductSpecialPriceController.clear();
    simpleProductSKUController.clear();
    simpleProductTotalStock.clear();
    variountProductSKUController.clear();
    variountProductTotalStock.clear();
    cityController.clear();
    hsnCodeController.clear();
    resultAttr = [];
    resultID = [];
    selectedAttributeValues = {};
    row = 1;
  }

  int row = 1;
  List<String> resultAttr = [];
  List<String> resultID = [];
  Map<String, List<AttributeValueModel>> selectedAttributeValues = {};

// <===  curent selected page ===>

  int currentPage = 1;
  get currentPageValue => currentPage;
  setCurrentPageValue(int value) {
    currentPage = value;
    notifyListeners();
  }

  FocusNode? productFocus,
      sortDescriptionFocus,
      tagFocus,
      totalAllowFocus,
      minOrderFocus,
      quantityStepSizeFocus,
      madeInFocus,
      warrantyPeriodFocus,
      guaranteePeriodFocus,
      vidioTypeFocus,
      simpleProductPriceFocus,
      simpleProductSpecialPriceFocus,
      simpleProductSKUFocus,
      simpleProductTotalStockFocus,
      variountProductSKUFocus,
      variountProductTotalStockFocus,
      hsnCodeFucosNode,
      rawKeyboardListenerFocus,
      tempFocusNode,
      attributeFocus = FocusNode();
//------------------------------------------------------------------------------
//======================= TextEditingController ================================

  TextEditingController productNameControlller = TextEditingController();
  TextEditingController sortDescriptionControlller = TextEditingController();
  TextEditingController tagsControlller = TextEditingController();
  TextEditingController totalAllowController = TextEditingController();
  TextEditingController minOrderQuantityControlller = TextEditingController();
  TextEditingController quantityStepSizeControlller = TextEditingController();
  TextEditingController madeInControlller = TextEditingController();
  TextEditingController warrantyPeriodController = TextEditingController();
  TextEditingController guaranteePeriodController = TextEditingController();
  TextEditingController vidioTypeController = TextEditingController();
  TextEditingController simpleProductPriceController = TextEditingController();
  TextEditingController simpleProductSpecialPriceController =
      TextEditingController();
  TextEditingController simpleProductSKUController = TextEditingController();
  TextEditingController simpleProductTotalStock = TextEditingController();
  TextEditingController variountProductSKUController = TextEditingController();
  TextEditingController variountProductTotalStock = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final ScrollController cityScrollController = ScrollController();
  TextEditingController hsnCodeController = TextEditingController();
// <===  product data ===>
  String? hsnCode; //hsn_code
  String? productName; //pro_input_name
  String? sortDescription; // short_description
  String? tags; // Tags
  String? taxId; // Tax (pro_input_tax)
  String? indicatorValue; // indicator
  String? madeIn; //made_in
  String? totalAllowQuantity; // total_allowed_quantity
  String? minOrderQuantity; // minimum_order_quantity
  String? quantityStepSize; // quantity_step_size
  String? warrantyPeriod; //warranty_period
  String? guaranteePeriod; //guarantee_period
  String? deliverabletypeValue = "1"; //deliverable_type
  String? deliverableZipcodes; //deliverable_zipcodes
  String? taxincludedinPrice = "0"; //is_prices_inclusive_tax
  String? isCODAllow = "0"; //cod_allowed
  String? isReturnable = "0"; //is_returnable
  String? isCancelable = "0"; //is_cancelable
  String? tillwhichstatus; //cancelable_till
  // => Variable For UI ...
  String? selectedCatName; // for UI
  int? selectedTaxID; // for UI
  //on-off toggles
  bool isToggled = false;
  bool isreturnable = false;
  bool isCODallow = false;
  bool iscancelable = false;
  bool taxincludedInPrice = false;
//for remove extra add
  int attributeIndiacator = 0;

  //
  int? selCityPos = -1;
  String? city;
  StateSetter? cityState;
  bool? isLoadingMoreCity;
  int cityOffset = 0;
  bool cityLoading = true;
  List<CityModel> citySearchLIst = [];
  bool isProgress = false;
  List<CityModel> cityList = [];
  String? selectedTypeOfVideo; // video_type
  String? videoUrl; //video
  File? videoOfProduct; // pro_input_video
  String? description; // pro_input_description
  String? selectedCatID; //category_id
  //attribute_values
  String? productType; //product_type
  String? variantStockLevelType =
      "product_level"; //variant_stock_level_type // defualt is product level  if not pass
  int curSelPos = 0;

// for simple product   if(product_type == simple_product)

  String? simpleproductStockStatus = "1"; //simple_product_stock_status
  String? simpleproductPrice; //simple_price
  String? simpleproductSpecialPrice; //simple_special_price
  String? simpleproductSKU; // product_sku
  String? simpleproductTotalStock; // product_total_stock
  String? variantStockStatus =
      "0"; //variant_stock_status //fix according to riddhi mam =0 for simple product // not give any option for selection

// for variable product
  List<List<AttributeValueModel>> finalAttList = [];
  List<List<AttributeValueModel>> tempAttList = [];
  String? variantsIds; //variants_ids
  String? variantPrice; // variant_price
  String? variantSpecialPrice; // variant_special_price
  String? variantImages; // variant_images

  //{if (variant_stock_level_type == product_level)}
  String? variantproductSKU; //sku_variant_type
  String? variantproductTotalStock; // total_stock_variant_type
  String stockStatus = '1'; // variant_status

  //{if(variant_stock_level_type == variable_level)}
  String? variantSku; // variant_sku
  String? variantTotalStock; // variant_total_stock
  String? variantLevelStockStatus; //variant_level_stock_status
  bool? isStockSelected;

//  other
  bool simpleProductSaveSettings = false;
  bool variantProductProductLevelSaveSettings = false;
  bool variantProductVariableLevelSaveSettings = false;
  late StateSetter taxesState;

// brand name
  String? selectedBrandName;
  String? selectedBrandId;

  // getting data
  List<TaxesModel> taxesList = [];
  List<AttributeSetModel> attributeSetList = [];
  List<AttributeModel> attributesList = [];
  List<AttributeValueModel> attributesValueList = [];
  List<ZipCodeModel> zipSearchList = [];
  List<CategoryModel> catagorylist = [];
  final List<TextEditingController> attrController = [];
  final List<TextEditingController> attrValController = [];
  List<bool> variationBoolList = [];
  List<int> attrId = [];
  List<int> attrValId = [];
  List<String> attrVal = [];
  List<BrandModel> brandList = [];
  String? data;
  bool suggessionisNoData = false;

  late String productImage, productImageUrl, uploadedVideoName;
  var mainImageProductImage;
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;

  List<String> otherPhotos = [];
  List<File>? otherPhotosFromGellery = [];
  List<String> otherImageUrl = [];
  List<Product_Varient> variationList = [];

  setproductName(String? value) {
    productName = value;
    notifyListeners();
  } //pro_input_name

  setsortDescription(String? value) {
    sortDescription = value;
    notifyListeners();
  } // short_description

  settags(String? value) {
    tags = value;
    notifyListeners();
  } // Tags

  settaxId(String? value) {
    taxId = value;
    notifyListeners();
  } // Tax (pro_input_tax)

  setindicatorValue(String? value) {
    indicatorValue = value;
    notifyListeners();
  } // indicator

  settmadeIn(String? value) {
    madeIn = value;
    notifyListeners();
  } //made_in

  settotalAllowQuantity(String? value) {
    totalAllowQuantity = value;
    notifyListeners();
  } // total_allowed_quantity

  setminOrderQuantity(String? value) {
    minOrderQuantity = value;
    notifyListeners();
  } // minimum_order_quantity

  setquantityStepSize(String? value) {
    quantityStepSize = value;
    notifyListeners();
  } // quantity_step_size

  setwarrantyPeriod(String? value) {
    warrantyPeriod = value;
    notifyListeners();
  } //warranty_period

  setguaranteePeriod(String? value) {
    guaranteePeriod = value;
    notifyListeners();
  } //guarantee_period

  setdeliverabletypeValue(String? value) {
    deliverabletypeValue = value;
    notifyListeners();
  } //deliverable_type

  setdeliverableZipcodes(String? value) {
    deliverableZipcodes = value;
    notifyListeners();
  } //deliverable_zipcodes

  settaxincludedinPrice(String? value) {
    taxincludedinPrice = value;
    notifyListeners();
  } //is_prices_inclusive_tax

  setisCODAllow(String? value) {
    isCODAllow = value;
    notifyListeners();
  } //cod_allowed

  setisReturnable(String? value) {
    isReturnable = value;
    notifyListeners();
  } //is_returnable

  setisCancelableget(String? value) {
    isCancelable = value;
    notifyListeners();
  } //is_cancelable

  settillwhichstatus(String? value) {
    tillwhichstatus = value;
    notifyListeners();
  } //cancelable_till

  setselectedCatName(String? value) {
    selectedCatName = value;
    notifyListeners();
  } // for UI

  setselectedTaxID(int? value) {
    selectedTaxID = value;
  } // for UI

  Future<void> addProductAPI(
    List<String> attributesValuesIds,
    BuildContext context,
    Function update,
  ) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      try {
        var request = http.MultipartRequest("POST", addProductsApi);
        request.headers.addAll(headers);

        request.fields[SellerId] = context.read<SettingProvider>().currentUerID;
        request.fields[ProInputName] = productName!;
        request.fields[ShortDescription] = sortDescription!;
        request.fields['hsn_code'] = hsnCode!;

        if (tags != null) {
          request.fields[Tags] = tags!;
        }
        if (taxId != null) {
          request.fields[ProInputTax] = taxId!;
        }
        if (indicatorValue != null) {
          request.fields[Indicator] = indicatorValue!;
        }
        if (madeIn != null) {
          request.fields[MadeIn] = madeIn!;
        }
        if (totalAllowQuantity != null) {
          request.fields[TotalAllowedQuantity] = totalAllowQuantity!;
        }
        request.fields[MinimumOrderQuantity] = minOrderQuantity!;
        request.fields[QuantityStepSize] = quantityStepSize!;
        if (warrantyPeriod != null) {
          request.fields[WarrantyPeriod] = warrantyPeriod!;
        }
        if (guaranteePeriod != null) {
          request.fields[GuaranteePeriod] = guaranteePeriod!;
        }
        request.fields[DeliverableType] = deliverabletypeValue!;
        request.fields[DeliverableZipcodes] = deliverableZipcodes ?? "null";
        request.fields[IsPricesInclusiveTax] = taxincludedinPrice!;
        request.fields[CodAllowed] = isCODAllow!;
        request.fields[IsReturnable] = isReturnable!;
        request.fields[IsCancelable] = isCancelable!;
        request.fields[ProInputImage] = productImage;

        if (tillwhichstatus != null) {
          request.fields[CancelableTill] = tillwhichstatus!;
        }
        if (otherPhotos.isNotEmpty) {
          request.fields[OtherImages] = otherPhotos.join(",");
        }
        if (selectedTypeOfVideo != null) {
          request.fields[VideoType] = selectedTypeOfVideo!;
        }
        if (videoUrl != null) {
          request.fields[Video] = videoUrl!;
        }
        if (uploadedVideoName != '') {
          request.fields[ProInputVideo] = uploadedVideoName;
        }
        if (description != null) {
          request.fields[ProInputDescription] = description ?? "";
        }
        if (selectedBrandName != null) {
          request.fields['brand'] = selectedBrandName!;
        }
        request.fields[CategoryId] = selectedCatID!;
        request.fields[ProductType] = productType!;
        request.fields[VariantStockLevelType] = variantStockLevelType!;
        request.fields[AttributeValues] = attributesValuesIds.join(",");

        if (productType == 'simple_product') {
          String? status;
          if (isStockSelected == null) {
            status = null;
          } else {
            status = simpleproductStockStatus;
          }
          request.fields[SimpleProductStockStatus] = status ?? 'null';
          request.fields[SimplePrice] = simpleProductPriceController.text;
          request.fields[SimpleSpecialPrice] =
              simpleProductSpecialPriceController.text;
          if (isStockSelected != null &&
              isStockSelected == true &&
              simpleproductSKU != null) {
            request.fields[ProductSku] = simpleproductSKU!;
            request.fields[ProductTotalStock] = simpleproductTotalStock!;
            request.fields[VariantStockStatus] = "0";
          }
        } else if (productType == 'variable_product') {
          String val = '', price = '', sprice = '', images = '';
          List<List<String>> imagesList = [];
          for (int i = 0; i < variationList.length; i++) {
            if (val == '') {
              val = variationList[i].id!.replaceAll(',', ' ');
              price = variationList[i].price!;
              sprice = variationList[i].disPrice ?? ' ';
            } else {
              val = "$val,${variationList[i].id!.replaceAll(',', ' ')}";
              price = "$price,${variationList[i].price!}";
              sprice = "$sprice,${variationList[i].disPrice ?? ' '}";
            }

            if (variationList[i].imageRelativePath != null) {
              if (variationList[i].imageRelativePath!.isNotEmpty &&
                  images != '') {
                images =
                    '$images,${variationList[i].imageRelativePath!.join(",")}';
              } else if (variationList[i].imageRelativePath!.isNotEmpty &&
                  images == '') {
                images = variationList[i].imageRelativePath!.join(",");
              }

              List<String> subListofImage = images.split(',');
              images = "";

              for (int j = 0; j < subListofImage.length; j++) {
                subListofImage[j] = '"${subListofImage[j]}"';
              }
              imagesList.add(subListofImage);
            }
          }
          request.fields[VariantsIds] = val;
          request.fields[VariantPrice] = price;
          request.fields[VariantSpecialPrice] = sprice;
          request.fields[variant_images] = imagesList.toString();
          if (variantStockLevelType == 'product_level') {
            request.fields[SkuVariantType] = variountProductSKUController.text;
            request.fields[TotalStockVariantType] =
                variountProductTotalStock.text;
            request.fields[VariantStatus] = stockStatus;
          } else if (variantStockLevelType == 'variable_level') {
            String sku = '', totalStock = '', stkStatus = '';
            for (int i = 0; i < variationList.length; i++) {
              if (sku == '') {
                sku = variationList[i].sku!;
                totalStock = variationList[i].stock!;
                stkStatus = variationList[i].stockStatus!;
              } else {
                sku = "$sku,${variationList[i].sku!}";
                totalStock = "$totalStock,${variationList[i].stock!}";
                stkStatus = "$stkStatus,${variationList[i].stockStatus!}";
              }
            }
            request.fields[VariantSku] = sku;
            request.fields[VariantTotalStock] = totalStock;
            request.fields[VariantLevelStockStatus] = stkStatus;
          }
        }
        print("parameter");
        print(request.fields.toString());
        var response = await request.send();
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var getdata = json.decode(responseString);
        bool error = getdata["error"];
        String msg = getdata['message'];
        if (!error) {
          await buttonController!.reverse();
          setSnackbar(msg, context);
          setCurrentPageValue(1);
          freshInitializationOfAddProduct();
          update();
        } else {
          await buttonController!.reverse();
          setSnackbar(msg, context);
        }
      } on TimeoutException catch (_) {
        setSnackbar(
          getTranslated(context, 'somethingMSg')!,
          context,
        );
      }
    } else {
      Future.delayed(const Duration(seconds: 2)).then(
        (_) async {
          await buttonController!.reverse();
          isNetworkAvail = false;
          update();
        },
      );
    }
  }
}
