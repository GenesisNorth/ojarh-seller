// Get Comman Switch :-     .
import 'package:flutter/material.dart';
import '../EditProduct.dart';

getCommanSwitch(int index, Function update) {
  return Switch(
    onChanged: (value) {
      if (index == 1) {
        editProvider!.isreturnable = value;
        if (value) {
          editProvider!.isReturnable = "1";
        } else {
          editProvider!.isReturnable = "0";
        }
      } else if (index == 2) {
        editProvider!.isCODallow = value;
        if (value) {
          editProvider!.isCODAllow = "1";
        } else {
          editProvider!.isCODAllow = "0";
        }
      } else if (index == 3) {
        editProvider!.taxincludedInPrice = value;
        if (value) {
          editProvider!.taxincludedinPrice = "1";
        } else {
          editProvider!.taxincludedinPrice = "0";
        }
      } else if (index == 4) {
        editProvider!.iscancelable = value;
        if (value) {
          editProvider!.isCancelable = "1";
        } else {
          editProvider!.isCancelable = "0";
        }
      }
      update();
    },
    value: () {
      if (index == 1) {
        return editProvider!.isreturnable;
      } else if (index == 2) {
        return editProvider!.isCODallow;
      } else if (index == 3) {
        return editProvider!.taxincludedInPrice;
      } else if (index == 4) {
        return editProvider!.iscancelable;
      }
      return true;
    }(),
  );
}
