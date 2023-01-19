import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Helper/Constant.dart';
import '../../../Model/OrdersModel/OrderModel.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/validation.dart';

class PriceDetail extends StatelessWidget {
  List<Order_Model> tempList;
  PriceDetail({Key? key, required this.tempList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius5)),
          color: white,
          boxShadow: const [
            BoxShadow(
                color: blarColor,
                offset: Offset(0, 0),
                blurRadius: 4,
                spreadRadius: 0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated(context, "PRICE_DETAIL")!,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                    ),
              ),
              const Divider(
                color: grey3,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getTranslated(context, "PRICE_LBL")!} :",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                    ),
                    Text(
                      DesignConfiguration.getPriceFormat(
                          context, double.parse(tempList[0].subTotal!))!,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getTranslated(context, "DELIVERY_CHARGE")!} :",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                    ),
                    Text(
                      "+ ${DesignConfiguration.getPriceFormat(context, double.parse(tempList[0].delCharge!))!}",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getTranslated(context, "TAXPER")!} (${tempList[0].taxPer!}) :",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                    ),
                    Text(
                      "+ ${DesignConfiguration.getPriceFormat(context, double.parse(tempList[0].taxAmt!))!}",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getTranslated(context, "PROMO_CODE_DIS_LBL")!} :",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                    ),
                    Text(
                      "- ${DesignConfiguration.getPriceFormat(context, double.parse(tempList[0].promoDis!))!}",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getTranslated(context, "WALLET_BAL")!} :",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: grey3,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                    ),
                    Text(
                      "- ${DesignConfiguration.getPriceFormat(context, double.parse(tempList[0].walBal!))!}",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PlusJakartaSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0,
                          ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: grey3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${getTranslated(context, "PAYABLE")!} :",
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: black,
                          fontWeight: FontWeight.w400,
                          fontFamily: "PlusJakartaSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 10.0,
                        ),
                  ),
                  Text(
                    DesignConfiguration.getPriceFormat(
                        context, double.parse(tempList[0].payable!))!,
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: black,
                          fontWeight: FontWeight.w400,
                          fontFamily: "PlusJakartaSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 10.0,
                        ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
