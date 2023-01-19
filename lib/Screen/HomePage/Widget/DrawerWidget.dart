//============================= Drawer Implimentation ==========================
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Helper/ApiBaseHelper.dart';
import '../../../Helper/Color.dart';
import '../../../Provider/settingProvider.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/dialogAnimate.dart';
import '../../../Widget/networkAvailablity.dart';
import '../../../Widget/parameterString.dart';
import '../../../Localization/Language_Constant.dart';
import '../../../Provider/privacyProvider.dart';
import '../../../Provider/walletProvider.dart';
import '../../../Widget/api.dart';
import '../../../Widget/routes.dart';
import '../../../Widget/sharedPreferances.dart';
import '../../../Widget/snackbar.dart';
import '../../../Widget/validation.dart';
import '../../../main.dart';
import '../../AddProduct/Add_Product.dart';
import '../../Authentication/Login.dart';
import '../../OrderList/OrderList.dart';
import '../../ProductList/ProductList.dart';
import '../../Profile/Profile.dart';
import '../../TermFeed/policys.dart';
import '../../WalletHistory/WalletHistory.dart';
import '../home.dart';
import 'logoutDialog.dart';

class DrawerWidget extends StatefulWidget {
  Function? setstaterofile;
  DrawerWidget({Key? key, this.setstaterofile});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int currentIndex = 0;
  String? verifyPassword;
  String? errorTrueMessage;
  List<String?> languageList = [];
  final passwordController = TextEditingController();
  FocusNode? passFocus = FocusNode();
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        languageList = [
          getTranslated(context, 'English'),
          getTranslated(context, 'Hindi'),
          getTranslated(context, 'Chinese'),
          getTranslated(context, 'Spanish'),
          getTranslated(context, 'Arabic'),
          getTranslated(context, 'Russian'),
          getTranslated(context, 'Japanese'),
          getTranslated(context, 'Deutch'),
        ];
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: ListView(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          _getHeader(),
          // _getDrawerItem(
          //     0, getTranslated(context, "HOME")!, Icons.home_outlined),
          _getDrawerItem(1, getTranslated(context, "ORDERS")!,
              Icons.shopping_basket_outlined),
          const Divider(),
          _getDrawerItem(3, getTranslated(context, "WALLETHISTORY")!,
              Icons.account_balance_wallet_outlined),
          _getDrawerItem(4, getTranslated(context, "PRODUCTS")!,
              Icons.production_quantity_limits_outlined),
          const Divider(),
          _getDrawerItem(10, getTranslated(context, 'Add Product')!, Icons.add),
          _getDrawerItem(
              5, getTranslated(context, "ChangeLanguage")!, Icons.translate),
          const Divider(),
          _getDrawerItem(6, getTranslated(context, "T_AND_C")!,
              Icons.speaker_notes_outlined),
          _getDrawerItem(
              7, getTranslated(context, "PRIVACYPOLICY")!, Icons.lock_outline),
          const Divider(),
          _getDrawerItem(
              9, getTranslated(context, "CONTACTUS")!, Icons.contact_page),
          _getDrawerItem(11, getTranslated(context, "Return Policy")!,
              Icons.assignment_returned_outlined),
          _getDrawerItem(12, getTranslated(context, "Shipping Policy")!,
              Icons.local_shipping_outlined),
          const Divider(),
          _getDrawerItem(
              13, getTranslated(context, "Delete Account")!, Icons.delete),
          _getDrawerItem(8, getTranslated(context, "LOGOUT")!, Icons.logout),
        ],
      ),
    );
  }
//Userd Widget for Drawer

  _getHeader() {
    return InkWell(
      child: Container(
        decoration: DesignConfiguration.back(),
        padding: const EdgeInsets.only(left: 10.0, bottom: 10),
        child: SafeArea(
          child: Column(
            children: [
              Opacity(
                opacity: 0.17000000178813934,
                child: Container(
                    width: width * 0.9,
                    height: 1,
                    decoration: const BoxDecoration(color: Color(0xffffffff))),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CUR_USERNAME!,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                    ),
                            maxLines: 1,
                            softWrap: false,
                          ),
                          Text(
                            getTranslated(context, "WALLET_BAL")! +
                                DesignConfiguration.getPriceFormat(
                                  context,
                                  double.parse(CUR_BALANCE),
                                )!,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: white),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 7,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  getTranslated(context, "EDIT_PROFILE_LBL")!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: white),
                                ),
                                const Icon(
                                  Icons.arrow_right_outlined,
                                  color: white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, right: 20),
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.0,
                          color: white,
                        ),
                      ),
                      child: LOGO != ''
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: sallerLogo(62),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: imagePlaceHolder(62),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        await Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Profile(),
          ),
        ).then(
          (value) {
            widget.setstaterofile;
          },
        );
        setState(
          () {},
        );
      },
    );
  }

  sallerLogo(double size) {
    return CircleAvatar(
      backgroundImage: NetworkImage(LOGO),
      radius: 25,
    );
  }

  imagePlaceHolder(double size) {
    return SizedBox(
      height: size,
      width: size,
      child: Icon(
        Icons.account_circle,
        color: Colors.white,
        size: size,
      ),
    );
  }

  _getDrawerItem(int index, String title, IconData icn) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icn,
          color: grad1Color,
        ),
        title: Text(
          title,
          style: const TextStyle(color: black, fontSize: 15),
        ),
        onTap: () {
          if (title == getTranslated(context, "HOME")!) {
          } else if (title == getTranslated(context, "ORDERS")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => OrderList(),
              ),
            );
          } else if (title == getTranslated(context, "WALLETHISTORY")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<WalletTransactionProvider>(
                  create: (context) => WalletTransactionProvider(),
                  child: const WalletHistory(),
                ),
              ),
            );
          } else if (title == getTranslated(context, "PRODUCTS")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>  ProductList(
                  flag: '',
                  fromNavbar: false,
                ),
              ),
            );
          } else if (title == getTranslated(context, "ChangeLanguage")!) {
            languageDialog();
          } else if (title == getTranslated(context, "T_AND_C")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: getTranslated(context, "TERM_CONDITIONS")!,
                  ),
                ),
              ),
            );
          } else if (title == getTranslated(context, "Delete Account")) {
            currentIndex = 0;
            deleteAccountDailog();
          } else if (title == getTranslated(context, "CONTACTUS")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: getTranslated(context, "CONTACTUS")!,
                  ),
                ),
              ),
            );
          } else if (title == getTranslated(context, "PRIVACYPOLICY")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: getTranslated(context, "PRIVACYPOLICY")!,
                  ),
                ),
              ),
            );
          } else if (title == getTranslated(context, "Return Policy")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: getTranslated(context, "Return Policy")!,
                  ),
                ),
              ),
            );
          } else if (title == getTranslated(context, "Shipping Policy")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: getTranslated(context, "Shipping Policy")!,
                  ),
                ),
              ),
            );
          } else if (title == getTranslated(context, "LOGOUT")!) {
            logOutDailog(context);
          } else if (title == getTranslated(context, "Add Product")) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AddProduct(),
              ),
            );
          }
        },
      ),
    );
  }

//==============================================================================
//============================= Language Implimentation ========================

  languageDialog() async {
    await dialogAnimate(
      context,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                  child: Text(
                    getTranslated(context, 'CHOOSE_LANGUAGE_LBL')!,
                    style: Theme.of(this.context).textTheme.subtitle1!.copyWith(
                          color: fontColor,
                        ),
                  ),
                ),
                const Divider(color: lightBlack),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: getLngList(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

//==============================================================================
//======================== Language List Generate ==============================

  List<Widget> getLngList(BuildContext ctx) {
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
            index,
            InkWell(
              onTap: () {
                if (mounted) {
                  setState(
                    () {
                      selectLan = index;
                      _changeLan(langCode[index], ctx);
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectLan == index ? grad2Color : white,
                            border: Border.all(color: grad2Color),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: selectLan == index
                                ? const Icon(
                                    Icons.check,
                                    size: 17.0,
                                    color: white,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    size: 15.0,
                                    color: white,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 15.0,
                          ),
                          child: Text(
                            languageList[index]!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: lightBlack),
                          ),
                        )
                      ],
                    ),
                    index == languageList.length - 1
                        ? Container(
                            margin: const EdgeInsetsDirectional.only(
                              bottom: 10,
                            ),
                          )
                        : const Divider(
                            color: lightBlack,
                          ),
                  ],
                ),
              ),
            ),
          ),
        )
        .values
        .toList();
  }

//=================================== delete user dialog =======================
//==============================================================================

  deleteAccountDailog() async {
    await dialogAnimate(
      context,
      StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //==================
                // when currentIndex == 0
                //==================
                currentIndex == 0
                    ? Text(
                        getTranslated(context, "Delete Account")!,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Container(),
                currentIndex == 0
                    ? const SizedBox(
                        height: 10,
                      )
                    : Container(),
                currentIndex == 0
                    ? Text(
                        getTranslated(
                          context,
                          'Your all return order request, ongoing orders, wallet amount and also your all data will be deleted. So you will not able to access this account further. We understand if you want you can create new account to use this application.',
                        )!,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle2!
                            .copyWith(),
                      )
                    : Container(),
                //==================
                // when currentIndex == 1
                //==================
                currentIndex == 1
                    ? Text(
                        getTranslated(context, "Please Verify Password")!,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                              color: black,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Container(),
                currentIndex == 1
                    ? const SizedBox(
                        height: 25,
                      )
                    : Container(),
                currentIndex == 1
                    ? Container(
                        height: 53,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: lightWhite1,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(passFocus);
                          },
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: passwordController,
                          focusNode: passFocus,
                          textInputAction: TextInputAction.next,
                          onChanged: (String? value) {
                            verifyPassword = value;
                          },
                          onSaved: (String? value) {
                            verifyPassword = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 5,
                            ),
                            suffixIconConstraints: const BoxConstraints(
                                minWidth: 40, maxHeight: 20),
                            hintText: getTranslated(context, "PASSHINT_LBL")!,
                            hintStyle: const TextStyle(
                                color: grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                            fillColor: lightWhite,
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    : Container(),
                //==================
                // when currentIndex == 2
                //==================

                currentIndex == 2
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
                //==================
                // when currentIndex == 2
                //==================
                currentIndex == 3
                    ? Center(
                        child: Text(
                          errorTrueMessage ??
                              getTranslated(context,
                                  "something Error Please Try again...!")!,
                        ),
                      )
                    : Container(),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  currentIndex == 0
                      ? TextButton(
                          child: Text(
                            getTranslated(context, 'LOGOUTNO')!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                  color: lightBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        )
                      : Container(),
                  currentIndex == 0
                      ? TextButton(
                          child: Text(
                            getTranslated(context, 'LOGOUTYES')!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                currentIndex = 1;
                              },
                            );
                          },
                        )
                      : Container(),
                ],
              ),
              currentIndex == 1
                  ? TextButton(
                      child: Text(
                        getTranslated(context, "Delete Now")!,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: () async {
                        setState(
                          () {
                            currentIndex = 2;
                          },
                        );
                        var mobile = await getPrefrence(Mobile);
                        await checkNetwork(mobile ?? "").then(
                          (value) {
                            setState(
                              () {
                                currentIndex = 3;
                              },
                            );
                          },
                        );
                      },
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Future<void> checkNetwork(
    String mobile,
  ) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      deleteAccountAPI(mobile);
    } else {
      Future.delayed(const Duration(seconds: 2)).then(
        (_) async {
          if (mounted) {
            setState(
              () {
                isNetworkAvail = false;
              },
            );
          }
        },
      );
    }
  }

  void _changeLan(String language, BuildContext ctx) async {
    Locale locale = await setLocale(language);

    MyApp.setLocale(ctx, locale);
  }

  Future<void> deleteAccountAPI(String mobile) async {
    var data = {
      UserId: context.read<SettingProvider>().CUR_USERID,
      "mobile": mobile,
      "password": verifyPassword
    };

    ApiBaseHelper().postAPICall(deleteSellerApi, data).then(
      (getdata) async {
        bool error = getdata['error'];
        String? msg = getdata['message'];
        if (!error) {
          currentIndex = 0;
          verifyPassword = "";
          setSnackbar(msg!, context);
          clearUserSession(context);
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (context) => const Login(),
              ),
              (Route<dynamic> route) => false);
        } else {
          errorTrueMessage = msg;
          currentIndex = 4;
          setState(() {});
          verifyPassword = "";
          setSnackbar(msg!, context);
        }
      },
      onError: (error) {
        setSnackbar(
          error.toString(),
          context,
        );
      },
    );
  }
}
