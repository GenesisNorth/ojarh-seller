import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';

class CommanButton extends StatelessWidget {
  bool selected;
  String title;
  CommanButton({
    Key? key,
    required this.selected,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Container(
        height: 31,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          gradient: LinearGradient(
            colors: [
              selected ? grad1Color : white,
              selected ? grad2Color : white
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0, 1],
            tileMode: TileMode.clamp,
          ),
          boxShadow: [
            selected
                ? const BoxShadow()
                : const BoxShadow(
                    color: blarColor,
                    offset: Offset(0, 0),
                    blurRadius: 4,
                    spreadRadius: 0),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: selected ? white : black,
              fontWeight: FontWeight.w400,
              fontFamily: "PlusJakartaSans",
              fontStyle: FontStyle.normal,
              fontSize: selected ? 16.0 : 14.0,
            ),
          ),
        ),
      ),
    );
  }
}

commanBtn(String title, bool fromNoDesing, bool outoffStock) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3.0),
    child: Container(
      // width: 97,
      height: 25,
      decoration: BoxDecoration(
        color: fromNoDesing
            ? outoffStock
                ? newPrimary.withOpacity(1.0)
                : Colors.green.withOpacity(0.80)
            : white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          fromNoDesing
              ? const BoxShadow()
              : const BoxShadow(
                  color: blarColor,
                  offset: Offset(0, 0),
                  blurRadius: 4,
                  spreadRadius: 0),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style:  TextStyle(
            color: fromNoDesing ?  white : black ,
            fontWeight: FontWeight.w400,
            fontFamily: "PlusJakartaSans",
            fontStyle: FontStyle.normal,
            fontSize: 10.0,
          ),
        ),
      ),
    ),
  );
}
