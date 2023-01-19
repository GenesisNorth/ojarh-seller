import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
import '../Widget/parameterString.dart';
import '../Widget/snackbar.dart';
import '../Widget/validation.dart';

class EditProductProvider extends ChangeNotifier {
  freshInitializationOfEditProduct() {
    variantProductProductLevelSaveSettings = false;
    variantProductVariableLevelSaveSettings = false;
    description = null;
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
    hsnCodeController.clear();
    variantproductSKU = null;
    variantproductTotalStock = null;
    stockStatus = '1';
    simpleproductPrice = null;
    simpleproductSpecialPrice = null;
    productImageRelativePath = null;
    productImage = null;
    productImageUrl = null;
    uploadedVideoName = null;
    otherPhotos = [];
    showOtherImages = [];
    variationList = [];
    isStockSelected = null;
    simpleProductSaveSettings = false;
    selCityPos = -1;
    city = null;
    isLoadingMoreCity = null;
    cityOffset = 0;
    cityLoading = true;
    citySearchLIst = [];
    isProgress = false;
    cityList = [];
    cityController.clear();
    row = 1;
    col = null;
    currentPage = 1;
    selectedCatName = null;
    selectedTaxID = null;
    mainImageProductImage = null;
    isToggled = false;
    isreturnable = false;
    isCODallow = false;
    iscancelable = false;
    taxincludedInPrice = false;
    attributeIndiacator = 0;
    isLoading = true;
    data;
    suggessionisNoData = false;
    selectedAttributeValues = {};
    hsnCode = null;
    oldVariantId = "";
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
    selectedTypeOfVideo = null;
    videoUrl = null;
    selectedCatID = null;
    productType = null;
    variantStockLevelType = "product_level";
    curSelPos = 0;
    simpleproductStockStatus;
    simpleproductSKU;
    simpleproductTotalStock;
    variantStockStatus = "0";
    finalAttList = [];
    tempAttList = [];
    variantSku;
    variantTotalStock;
    variantLevelStockStatus;
    taxesList = [];
    attributeSetList = [];
    attributesList = [];
    attributesValueList = [];
    zipSearchList = [];
    catagorylist = [];
    attrController.clear();
    variationBoolList = [];
    attrId = [];
    attrValId = [];
    attrVal = [];
    selectedBrandName = null;
    selectedBrandId = null;
    brandList = [];
    selectedAttribute = [];
    resultAttr = [];
    resultID = [];
    max = null;
  }

  int? max;
  List<String> resultAttr = [];
  List<String> resultID = [];
  List<String> selectedAttribute = [];

//------------------------------------------------------------------------------
//========================= For Form Validation ================================
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? hsnCode; //hsn_code
  String? oldVariantId = "";
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
  //File? mainProductImage;//pro_input_image
  String? selectedTypeOfVideo; // video_type
  String? videoUrl; //video

  String? selectedCatID; //category_id
  //attribute_values
  String? productType; //product_type
  String? variantStockLevelType =
      "product_level"; //variant_stock_level_type // defualt is product level  if not pass
  int curSelPos = 0;

// for simple product   if(product_type == simple_product)

  String? simpleproductStockStatus; //simple_product_stock_status

  String? simpleproductSKU; // product_sku
  String? simpleproductTotalStock; // product_total_stock
  String? variantStockStatus =
      "0"; //variant_stock_status //fix according to riddhi mam =0 for simple product // not give any option for selection

// for variable product
  List<List<AttributeValueModel>> finalAttList = [];
  List<List<AttributeValueModel>> tempAttList = [];

  //{if(variant_stock_level_type == variable_level)}
  String? variantSku; // variant_sku
  String? variantTotalStock; // variant_total_stock
  String? variantLevelStockStatus; //variant_level_stock_status

  // getting data
  List<TaxesModel> taxesList = [];
  List<AttributeSetModel> attributeSetList = [];
  List<AttributeModel> attributesList = [];
  List<AttributeValueModel> attributesValueList = [];
  List<ZipCodeModel> zipSearchList = [];
  List<CategoryModel> catagorylist = [];
  final List<TextEditingController> attrController = [];
  List<bool> variationBoolList = [];
  List<int> attrId = [];
  List<int> attrValId = [];
  List<String> attrVal = [];

// temprary variable for test
  late Map<String, List<AttributeValueModel>> selectedAttributeValues = {};
  // for UI
  String? selectedCatName; // for UI
  int? selectedTaxID; // for UI
  var mainImageProductImage;

//on-off toggles
  bool isToggled = false;
  bool isreturnable = false;
  bool isCODallow = false;
  bool iscancelable = false;

  bool taxincludedInPrice = false;

//for remove extra add
  int attributeIndiacator = 0;

// network variable
  bool isLoading = true;
  String? data;
  bool suggessionisNoData = false;
  int currentPage = 1;
  int? col;
  int row = 1;
  int? selCityPos = -1;
  String? city;
  StateSetter? cityState;
  bool? isLoadingMoreCity;
  int cityOffset = 0;
  bool cityLoading = true;
  List<CityModel> citySearchLIst = [];
  final ScrollController cityScrollController = ScrollController();
  bool isProgress = false;
  List<CityModel> cityList = [];
  final TextEditingController cityController = TextEditingController();
  String? simpleproductPrice; //simple_price
  String? simpleproductSpecialPrice; //simple_special_price
  String? productImageRelativePath,
      productImage,
      productImageUrl,
      uploadedVideoName;
  List<String> otherPhotos = [];
  List<String> showOtherImages = [];
  List<Product_Varient> variationList = [];
  bool? isStockSelected;
//  other
  bool simpleProductSaveSettings = false;
//{if (variant_stock_level_type == product_level)}
  String? variantproductSKU; //sku_variant_type
  String? variantproductTotalStock; // total_stock_variant_type
  String stockStatus = '1'; // variant_status

  String? description; // pro_input_description
  late StateSetter taxesState;
  bool variantProductProductLevelSaveSettings = false;
  bool variantProductVariableLevelSaveSettings = false;
// brand name
  String? selectedBrandName;
  String? selectedBrandId;

  List<BrandModel> brandList = [];

// Focus Node.
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
      rawKeyboardListenerFocus,
      tempFocusNode,
      hsnCodeFucosNode,
      attributeFocus = FocusNode();

//----------------------------------------------------------------------------
//======================= TextEditingController ==============================

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
  TextEditingController hsnCodeController = TextEditingController();

  Future<void> addProductAPI(
    List<String> attributesValuesIds,
    BuildContext context,
    Function update,
    String id,
  ) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      try {
        var request = http.MultipartRequest("POST", editProductApi);
        request.headers.addAll(headers);
        request.fields[SellerId] = context.read<SettingProvider>().CUR_USERID!;
        request.fields[editProductId] = id;
        request.fields[EditVariantId] = oldVariantId!;
        request.fields[ProInputName] = productName!;
        request.fields['hsn_code'] = hsnCode!;
        if (selectedBrandName != null) {
          request.fields['brand'] = selectedBrandName!;
        }
        request.fields[ShortDescription] = sortDescription!;
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
        request.fields[TotalAllowedQuantity] = totalAllowQuantity!;
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
        request.fields[ProInputImage] = productImageRelativePath!;
        if (tillwhichstatus != null) {
          request.fields[CancelableTill] = tillwhichstatus!;
        }
        if (otherPhotos.isNotEmpty) {
          request.fields[OtherImages] = otherPhotos.join(",");
        }

        if (selectedTypeOfVideo != null) {
          request.fields[VideoType] = selectedTypeOfVideo!;
        }
        if (videoUrl != null) request.fields[Video] = videoUrl!;
        if (uploadedVideoName != '') {
          request.fields[ProInputVideo] = uploadedVideoName!;
        }
        request.fields[ProInputDescription] = description ?? "";
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
            if (isStockSelected == true) {
              request.fields[ProductSku] = simpleproductSKU!;
              request.fields[ProductTotalStock] = simpleproductTotalStock!;
              request.fields[VariantStockStatus] = "0";
            }
          }
        } else if (productType == 'variable_product') {
          String val = '', price = '', sprice = '', images = '';
          List<List<String>> imagesList = [];

          for (int i = 0; i < variationList.length; i++) {
            String testing = "";
            if (variationList[i].attribute_value_ids.toString() != "null") {
              testing =
                  variationList[i].attribute_value_ids!.replaceAll(',', ' ');
            } else {
              testing = variationList[i].id!.replaceAll(',', ' ');
            }
            if (testing != "") {
              if (val == "") {
                val = testing;
                price = variationList[i].price!;
                sprice = variationList[i].disPrice ?? ' ';
              } else {
                val = "$val,$testing";
                price = "$price,${variationList[i].price!}";
                sprice = "$sprice,${variationList[i].disPrice ?? ' '}";
              }
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
              for (int j = 0; j < subListofImage.length; j++) {
                subListofImage[j] = '"${subListofImage[j]}"';
              }
              imagesList.add(subListofImage);
            }
          }

          request.fields[VariantsIds] = val;
          request.fields[VariantPrice] = price;
          request.fields[VariantSpecialPrice] = sprice;
          // if (imagesList.length == 1) {
          //   request.fields[variant_images] = imagesList[0].toString();
          // } else {
          request.fields[variant_images] = imagesList.toString();
          // }
          if (variantStockLevelType == 'product_level') {
            if (isStockSelected == true) {
              request.fields[SkuVariantType] =
                  variountProductSKUController.text;
              request.fields[TotalStockVariantType] =
                  variountProductTotalStock.text;
              request.fields[VariantStatus] = stockStatus;
            }
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
            print(" enable staoock managemenr :   ${isStockSelected}");
            if (isStockSelected == true) {
              request.fields[VariantSku] = sku;
              request.fields[VariantTotalStock] = totalStock;
              request.fields[VariantLevelStockStatus] = stkStatus;
            }
          }
        }
        print("parameter : ${request.fields.toString()}");
        print(request.files.toString());
        print(request.fields.toString());
        print(request.fields[variant_images].toString());
        var response = await request.send();
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var getdata = json.decode(responseString);
        bool error = getdata["error"];
        print("message : ${getdata['message']}");
        String msg = getdata['message'];
        if (!error) {
          await buttonController!.reverse();

          setSnackbar(msg, context);
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
