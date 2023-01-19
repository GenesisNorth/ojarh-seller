import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sellermultivendor/Helper/Color.dart';
import '../../Model/OrdersModel/OrderModel.dart';
import '../../Provider/orderListProvider.dart';
import '../../Provider/settingProvider.dart';
import '../../Widget/desing.dart';
import '../../Widget/networkAvailablity.dart';
import '../../Widget/noNetwork.dart';
import '../../Widget/validation.dart';
import 'Widget/commanDesingField.dart';
import 'Widget/orderIteam.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

OrderListProvider? orderListProvider;
int currentSelected = 0;

class _OrderListState extends State<OrderList> with TickerProviderStateMixin {
  setStateNow() {
    setState(() {});
  }

  bool serachIsEnable = false;
  @override
  void initState() {
    currentSelected = 0;
    orderListProvider = Provider.of<OrderListProvider>(context, listen: false);
    orderListProvider!.initializeAllVariable();

    orderListProvider!.scrollOffset = 0;
    Future.delayed(
      Duration.zero,
      () {
        orderListProvider!.appBarTitle = Text(
          getTranslated(context, "Orders")!,
          style: const TextStyle(color: grad2Color),
        );
        orderListProvider!.getOrder(setStateNow, context);
      },
    );

    orderListProvider!.buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    orderListProvider!.scrollController =
        ScrollController(keepScrollOffset: true);
    orderListProvider!.scrollController!
        .addListener(_transactionscrollListener);

    orderListProvider!.buttonSqueezeanimation = Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: orderListProvider!.buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );

    orderListProvider!.controller.addListener(
      () {
        if (orderListProvider!.controller.text.isEmpty) {
          if (mounted) {
            setState(
              () {
                orderListProvider!.searchText = "";
              },
            );
          }
        } else {
          if (mounted) {
            setState(
              () {
                orderListProvider!.searchText =
                    orderListProvider!.controller.text;
              },
            );
          }
        }

        if (orderListProvider!.lastsearch != orderListProvider!.searchText &&
            (orderListProvider!.searchText == '' ||
                (orderListProvider!.searchText.length > 2))) {
          orderListProvider!.lastsearch = orderListProvider!.searchText;
          orderListProvider!.scrollLoadmore = true;
          orderListProvider!.scrollOffset = 0;
          orderListProvider!.getOrder(setStateNow, context);
        }
      },
    );
    super.initState();
  }

  _transactionscrollListener() {
    if (orderListProvider!.scrollController!.offset >=
            orderListProvider!.scrollController!.position.maxScrollExtent &&
        !orderListProvider!.scrollController!.position.outOfRange) {
      if (mounted) {
        setState(
          () {
            orderListProvider!.scrollLoadmore = true;
            orderListProvider!.getOrder(setStateNow, context);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightWhite,
      // appBar: getAppbar(),
      body: isNetworkAvail
          ? _showContent()
          : noInternet(
              context,
              setStateNoInternate,
              orderListProvider!.buttonSqueezeanimation,
              orderListProvider!.buttonController,
            ),
    );
  }

  void _handleSearchStart() {
    if (!mounted) return;
    setState(
      () {
        orderListProvider!.isSearching = true;
      },
    );
  }

  Future<void> _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: orderListProvider!.startDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(
        () {
          orderListProvider!.startDate = picked;
          orderListProvider!.start =
              DateFormat('dd-MM-yyyy').format(orderListProvider!.startDate);

          if (orderListProvider!.start != null &&
              orderListProvider!.end != null) {
            orderListProvider!.scrollLoadmore = true;
            orderListProvider!.scrollOffset = 0;
            orderListProvider!.getOrder(setStateNow, context);
          }
        },
      );
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: orderListProvider!.startDate,
        firstDate: orderListProvider!.startDate,
        lastDate: DateTime.now());
    if (picked != null) {
      setState(
        () {
          orderListProvider!.endDate = picked;
          orderListProvider!.end =
              DateFormat('dd-MM-yyyy').format(orderListProvider!.endDate);
          if (orderListProvider!.start != null &&
              orderListProvider!.end != null) {
            orderListProvider!.scrollLoadmore = true;
            orderListProvider!.scrollOffset = 0;
            orderListProvider!.getOrder(setStateNow, context);
          }
        },
      );
    }
  }

  void _handleSearchEnd() {
    if (!mounted) return;
    setState(
      () {
        serachIsEnable = false;
        orderListProvider!.isSearching = false;
        orderListProvider!.controller.clear();
      },
    );
  }

  setStateNoInternate() async {
    _playAnimation();

    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        isNetworkAvail = await isNetworkAvailable();
        if (isNetworkAvail) {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (BuildContext context) => super.widget,
            ),
          ).then(
            (value) {
              setState(
                () {},
              );
            },
          );
        } else {
          await orderListProvider!.buttonController!.reverse();
          if (mounted) {
            setState(
              () {},
            );
          }
        }
      },
    );
  }

  AppBar getAppbar() {
    return AppBar(
      title: orderListProvider!.appBarTitle,
      elevation: 5,
      titleSpacing: 0,
      iconTheme: const IconThemeData(color: primary),
      backgroundColor: white,
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => Navigator.of(context).pop(),
              child: const Center(
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: primary,
                  size: 30,
                ),
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: DesignConfiguration.shadow(),
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              if (!mounted) return;
              setState(
                () {
                  if (orderListProvider!.iconSearch.icon == Icons.search) {
                    orderListProvider!.iconSearch = const Icon(
                      Icons.close,
                      color: primary,
                      size: 25,
                    );
                    orderListProvider!.appBarTitle = TextField(
                      controller: orderListProvider!.controller,
                      autofocus: true,
                      style: const TextStyle(
                        color: primary,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search, color: primary),
                        hintText: getTranslated(context, "Search"),
                        hintStyle: const TextStyle(color: primary),
                      ),
                    );
                    _handleSearchStart();
                  } else {
                    _handleSearchEnd();
                  }
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: orderListProvider!.iconSearch,
            ),
          ),
        ),
      ],
    );
  }

  _showContent() {
    return NotificationListener<ScrollNotification>(
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: orderListProvider!.scrollController,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [grad1Color, grad2Color],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0, 1],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Opacity(
                          opacity: 0.17000000178813934,
                          child: Container(
                            width: width * 0.9,
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Color(
                                0xffffffff,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            serachIsEnable
                                ? Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 8.0),
                                    child: SizedBox(
                                      height: 60,
                                      width: width * 0.7,
                                      child: TextField(
                                        controller:
                                            orderListProvider!.controller,
                                        autofocus: true,
                                        style: const TextStyle(
                                          color: white,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.search,
                                              color: white),
                                          hintText:
                                              getTranslated(context, "Search"),
                                          hintStyle:
                                              const TextStyle(color: white),
                                          disabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: white,
                                            ),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 36,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        top: 7.0,
                                        start: 15,
                                        end: 15,
                                      ),
                                      child: Text(
                                        getTranslated(context, 'Orders')!,
                                        style: const TextStyle(
                                          fontFamily: 'PlusJakartaSans',
                                          color: Color(0xffffffff),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 15,
                                end: 15,
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (!mounted) return;
                                  setState(
                                    () {
                                      if (serachIsEnable == false) {
                                        serachIsEnable = true;
                                        _handleSearchStart();
                                      } else {
                                        _handleSearchEnd();
                                      }
                                    },
                                  );
                                },
                                child: Icon(
                                  serachIsEnable ? Icons.close : Icons.search,
                                  color: white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // DetailHeaderOne(setStateNow: setStateNow),
                // DetailHeaderTwo(setStateNow: setStateNow),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 20, left: 10, right: 10),
                  child: SizedBox(
                    width: width,
                    height: 70,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CommanDesingWidget(
                          title: getTranslated(context, "ORDER")!,
                          icon: Icons.shopping_cart,
                          index: 0,
                          onTapAction: null,
                          update: setStateNow,
                        ),
                        CommanDesingWidget(
                          title: getTranslated(context, "RECEIVED_LBL")!,
                          icon: Icons.archive,
                          index: 1,
                          onTapAction: orderListProvider!.statusList[1],
                          update: setStateNow,
                        ),
                        CommanDesingWidget(
                          title: getTranslated(context, "PROCESSED_LBL")!,
                          icon: Icons.work,
                          index: 2,
                          onTapAction: orderListProvider!.statusList[2],
                          update: setStateNow,
                        ),
                        CommanDesingWidget(
                          title: getTranslated(context, "SHIPED_LBL")!,
                          icon: Icons.airport_shuttle,
                          index: 3,
                          onTapAction: orderListProvider!.statusList[3],
                          update: setStateNow,
                        ),
                        CommanDesingWidget(
                          title: getTranslated(context, "DELIVERED_LBL")!,
                          icon: Icons.assignment_turned_in,
                          index: 4,
                          onTapAction: orderListProvider!.statusList[4],
                          update: setStateNow,
                        ),

                        // index = 5
                        CommanDesingWidget(
                          title: getTranslated(context, "CANCELLED_LBL")!,
                          icon: Icons.cancel,
                          index: 5,
                          onTapAction: orderListProvider!.statusList[5],
                          update: setStateNow,
                        ),

                        CommanDesingWidget(
                          title: getTranslated(context, "RETURNED_LBL")!,
                          icon: Icons.upload,
                          index: 6,
                          onTapAction: orderListProvider!.statusList[6],
                          update: setStateNow,
                        )
                      ],
                    ),
                  ),
                ),
                _filterRow(),
                orderListProvider!.scrollNodata
                    ? SizedBox(
                      height:  height* 0.7,
                      child: DesignConfiguration.getNoItem(context))
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsetsDirectional.only(
                            start: 15, end: 15),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderListProvider!.orderList.length,
                        itemBuilder: (context, index) {
                          Order_Model? item;
                          try {
                            item = orderListProvider!.orderList.isEmpty
                                ? null
                                : orderListProvider!.orderList[index];
                            if (orderListProvider!.scrollLoadmore &&
                                index ==
                                    (orderListProvider!.orderList.length - 1) &&
                                orderListProvider!
                                        .scrollController!.position.pixels <=
                                    0) {
                              orderListProvider!.getOrder(setStateNow, context);
                            }
                          } on Exception catch (_) {}

                          return item == null
                              ? Container()
                              : MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: OrderIteam(
                                    index: index,
                                    update: setStateNow,
                                  ),
                                );
                        },
                      ),
              ],
            ),
          ),
          orderListProvider!.scrollGettingData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<void> _playAnimation() async {
    try {
      await orderListProvider!.buttonController!.forward();
    } on TickerCanceled {}
  }

  void filterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ButtonBarTheme(
          data: const ButtonBarThemeData(
            alignment: MainAxisAlignment.center,
          ),
          child: AlertDialog(
            elevation: 2.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            contentPadding: const EdgeInsets.all(0.0),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 19.0, bottom: 16.0),
                    child: Text(
                      getTranslated(context, "FILTER_BY")!,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: fontColor),
                    ),
                  ),
                  const Divider(color: lightBlack),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: getStatusList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> getStatusList() {
    return orderListProvider!.statusList
        .asMap()
        .map(
          (index, element) => MapEntry(
            index,
            Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: TextButton(
                    child: Text(
                      StringValidation.capitalize(
                        orderListProvider!.statusList[index],
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: lightBlack),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          orderListProvider!.activeStatus = index == 0
                              ? null
                              : orderListProvider!.statusList[index];
                          orderListProvider!.scrollLoadmore = true;
                          orderListProvider!.scrollOffset = 0;
                        },
                      );
                      orderListProvider!.getOrder(setStateNow, context);
                      Navigator.pop(context, 'option $index');
                    },
                  ),
                ),
                const Divider(
                  color: lightBlack,
                  height: 1,
                ),
              ],
            ),
          ),
        )
        .values
        .toList();
  }

  _filterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .375,
            height: 30,
            child: ElevatedButton(
              onPressed: () => _startDate(context),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: primary),
                backgroundColor: primary,
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.grey,
              ),
              child: Text(
                orderListProvider!.start == null
                    ? getTranslated(context, "Start Date")!
                    : orderListProvider!.start!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .375,
            height: 30,
            child: ElevatedButton(
              onPressed: () => _endDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.grey,
              ),
              child: Text(orderListProvider!.end == null
                  ? getTranslated(context, "End Date")!
                  : orderListProvider!.end!),
            ),
          ),
          Container(
            height: 30,
            width: 40,
            child: ElevatedButton(
              onPressed: () {
                setState(
                  () {
                    orderListProvider!.start = null;
                    orderListProvider!.end = null;
                    orderListProvider!.startDate = DateTime.now();
                    orderListProvider!.endDate = DateTime.now();
                    orderListProvider!.scrollLoadmore = true;
                    orderListProvider!.scrollOffset = 0;
                  },
                );
                orderListProvider!.getOrder(setStateNow, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.grey,
                padding: const EdgeInsets.all(0),
              ),
              child: const Center(
                child: Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
