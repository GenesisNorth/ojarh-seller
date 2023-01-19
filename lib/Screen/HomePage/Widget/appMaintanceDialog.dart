import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../Widget/dialogAnimate.dart';
import '../../../Widget/parameterString.dart';
import '../../../Widget/validation.dart';

void appMaintenanceDialog(BuildContext context) async {
    await dialogAnimate(
      context,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              title: Text(
                getTranslated(context, 'APP_MAINTENANCE')!,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child:
                        Lottie.asset('assets/animation/app_maintenance.json'),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    MAINTENANCE_MESSAGE != ''
                        ? '$MAINTENANCE_MESSAGE'
                        : getTranslated(
                            context, 'MAINTENANCE_DEFAULT_MESSAGE')!,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
