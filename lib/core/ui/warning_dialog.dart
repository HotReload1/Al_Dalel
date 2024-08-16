import 'package:al_dalel/core/configuration/assets.dart';
import 'package:al_dalel/core/configuration/styles.dart';
import 'package:al_dalel/core/ui/save_cancel_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog(
      {super.key,
      required this.isWithWarningLogo,
      required this.message,
      required this.isWithButton});
  final bool isWithWarningLogo;
  final bool isWithButton;
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      backgroundColor: Styles.colorPrimary,
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              isWithWarningLogo
                  ? Column(
                      children: [
                        Image.asset(
                          AssetsLink.WARNING_LOGO,
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              isWithButton
                  ? SaveCancelButtons(
                      onSavePressed: () {
                        Navigator.of(context).pop(true);
                      },
                      primaryText: "نعم",
                      secondaryText: "لا",
                      onCancelPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
