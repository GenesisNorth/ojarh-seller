import 'package:flutter/material.dart';
import '../Helper/Constant.dart';
import '../Screen/EditProduct/EditProduct.dart';
import '../Widget/parameterString.dart';
import '../Model/city/cityModel.dart';
import '../Repository/countryRepositry.dart';
import '../Screen/AddProduct/Add_Product.dart';

class CountryProvider extends ChangeNotifier {
  String errorMessage = '';

  Future<bool> setCountrys(bool isSearchCity, bool fromAddProduct) async {
    try {
      var parameter = {
        LIMIT: perPage.toString(),
        OFFSET: fromAddProduct
            ? addProvider!.cityOffset.toString()
            : editProvider!.cityOffset.toString(),
      };
      if (isSearchCity) {
        parameter[SEARCH] = fromAddProduct
            ? addProvider!.cityController.text
            : editProvider!.cityController.text;
        parameter[OFFSET] = '0';
        if (fromAddProduct) {
          addProvider!.citySearchLIst.clear();
        } else {
          editProvider!.citySearchLIst.clear();
        }
      }
      var result = await CountryRepository.setCountry(parameter: parameter);
      bool error = result['error'];
      errorMessage = result['message'];
      if (!error) {
        var data = result['data'];
        if (fromAddProduct) {
          addProvider!.cityList =
              (data as List).map((data) => CityModel.fromJson(data)).toList();
          addProvider!.citySearchLIst.addAll(addProvider!.cityList);
        } else {
          editProvider!.cityList =
              (data as List).map((data) => CityModel.fromJson(data)).toList();
          editProvider!.citySearchLIst.addAll(editProvider!.cityList);
        }
      }
      if (fromAddProduct) {
        addProvider!.cityLoading = false;
        addProvider!.isLoadingMoreCity = false;
        addProvider!.isProgress = false;
        addProvider!.cityOffset += perPage;
      } else {
        editProvider!.cityLoading = false;
        editProvider!.isLoadingMoreCity = false;
        editProvider!.isProgress = false;
        editProvider!.cityOffset += perPage;
        if (editProvider!.cityState != null) {
          // editProvider!.cityState!(() {});
        }
      }
      return error;
    } catch (e) {
      print('error message  country: $e');
      errorMessage = e.toString();
      return true;
    }
  }
}
