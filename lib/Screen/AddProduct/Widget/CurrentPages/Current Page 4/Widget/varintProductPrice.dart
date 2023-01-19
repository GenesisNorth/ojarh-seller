import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../Helper/Color.dart';
import '../../../../../../Provider/settingProvider.dart';
import '../../../../../../Widget/validation.dart';
import '../../../../Add_Product.dart';
import '../../../getCommanWidget.dart';

class VariantProductPrice extends StatelessWidget {
  int pos;
  VariantProductPrice({Key? key, required this.pos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getPrimaryCommanText(getTranslated(context, "PRICE_LBL")!, true),
          Container(
            width: width * 0.4,
            height: height * 0.06,
            padding: const EdgeInsets.only(),
            child: TextFormField(
              keyboardType: TextInputType.number,
              initialValue: addProvider!.variationList[pos].price ?? '',
              style: const TextStyle(
                color: black,
                fontWeight: FontWeight.normal,
              ),
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (String? value) {
                addProvider!.variationList[pos].price = value;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xfff5f5f5),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 40, maxHeight: 20),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xffe6e6e6),
                  ),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: lightWhite),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
