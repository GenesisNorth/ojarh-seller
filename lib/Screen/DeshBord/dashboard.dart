import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:sellermultivendor/Screen/DeshBord/profileagain.dart';
import 'package:sellermultivendor/Widget/validation.dart';
import '../../Helper/Color.dart';
import '../../Widget/desing.dart';
import '../HomePage/home.dart';
import '../OrderList/OrderList.dart';
import '../ProductList/ProductList.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Widget> fragments;
  int _curBottom = 0;
  @override
  void initState() {
    super.initState();
    fragments = [
      const Home(),
      OrderList(),
      ProductList(
        flag: "",
        fromNavbar: true,
      ),
      const ProfileAgain(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomNav(),
      body: fragments[_curBottom],
    );
  }

  getBottomNav() {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          boxShadow: [
            BoxShadow(
                color: Color(0x17000000),
                offset: Offset(0, -3),
                blurRadius: 6,
                spreadRadius: 0)
          ],
          color: white),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
        child: BottomNavigationBar(
          unselectedItemColor: primary,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('home'),
              ),
              activeIcon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('homeSelected'),
              ),
              label: getTranslated(context, 'Home')!,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('order'),
              ),
              activeIcon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('orderselected'),
              ),
              label: getTranslated(context, 'Orders')!,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('product'),
              ),
              activeIcon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('productSelected'),
              ),
              label: getTranslated(context, 'PRODUCTS')!,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('profile'),
              ),
              activeIcon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('profileSelected'),
              ),
              label: getTranslated(context, 'Profile')!,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _curBottom,
          selectedItemColor: primary,
          onTap: (int index) {
            if (mounted) {
              setState(
                () {
                  _curBottom = index;
                },
              );
            }
          },
          elevation: 25,
        ),
      ),
    );
  }
}
