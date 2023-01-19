import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/validation.dart';

class GetRowFields extends StatelessWidget {
  String title;
  String value;
  bool simple;
  GetRowFields({
    Key? key,
    required this.value,
    required this.title,
    required this.simple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: title == "${getTranslated(context, 'Final Total')} : " ||
                  title == getTranslated(context, "Grand Final Total :")!
              ? Theme.of(context).textTheme.button!.copyWith(
                    color: black,
                    fontWeight: FontWeight.w400,
                    fontFamily: "PlusJakartaSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  )
              : Theme.of(context).textTheme.button!.copyWith(
                    color: grey3,
                    fontWeight: FontWeight.w400,
                    fontFamily: "PlusJakartaSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
        ),
        Text(
          () {
            if (simple) {
              return value;
            } else {
              return DesignConfiguration.getPriceFormat(
                context,
                double.parse(value),
              )!;
            }
          }(),
          style: Theme.of(context).textTheme.button!.copyWith(
                color: title == "${getTranslated(context, 'Final Total')} : " ||
                        title == getTranslated(context, "Grand Final Total :")!
                    ? black
                    : grey3,
                fontWeight: FontWeight.w400,
                fontFamily: "PlusJakartaSans",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
        ),
      ],
    );
  }
}
