import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Helper/Color.dart';
import '../../../Widget/routes.dart';
import '../../DeshBord/dashboard.dart';

getAppBarHome(BuildContext context, String appName) {
  return AppBar(
    title: Text(
      appName,
      style: const TextStyle(
        color: grad2Color,
      ),
    ),
    // flexibleSpace: Container(
    //   decoration: const BoxDecoration(
    //   gradient: LinearGradient(
    //       colors: [grad1Color, grad2Color],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       stops: [0, 1],
    //       tileMode: TileMode.clamp,
    //     ),
    //   ),
    // ),
    backgroundColor: white,
    iconTheme: const IconThemeData(
      color: grad2Color,
    ),
  );
}

floatingBtn(BuildContext context) {
  return Container(
        height: 40.0,
        width: 40.0,
        child: FittedBox(
          child: FloatingActionButton(
        backgroundColor: newPrimary,
        child: const Icon(
          Icons.add,
          size: 32,
          color: white,
        ),
        onPressed: () {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => Test(),
          //   ),
          // );
          Routes.navigateToAddProduct(context);
        },
      ),
      // const SizedBox(height: 10),
        ),
  );
}
