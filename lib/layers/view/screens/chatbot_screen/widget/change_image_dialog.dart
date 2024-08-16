import 'dart:io';

import 'package:al_dalel/layers/bloc/chatbot/chatbot_cubit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:al_dalel/core/configuration/styles.dart';

import '../../../../../injection_container.dart';

class ChangeImageDialog {
  void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: DialogContent(),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }
}

class DialogContent extends StatelessWidget {
  DialogContent({super.key});

  File? selectedImage;

  takePhoto(BuildContext context) async {
    final res = await ImagePicker().pickImage(source: ImageSource.camera);

    if (res != null) {
      selectedImage = File(res!.path);
      sl<ChatBotCubit>().getPlacesByChatBot(selectedImage!);
      Navigator.of(context).pop();
    }
  }

  pickImage(BuildContext context) async {
    final res = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (res != null) {
      selectedImage = File(res!.path);
      sl<ChatBotCubit>().getPlacesByChatBot(selectedImage!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).viewInsets,
      width: double.maxFinite,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: BoxDecoration(
        color: Styles.colorPrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Material(
        color: Styles.colorPrimary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "إختر صورة",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.white.withOpacity(0.9),
              height: 1,
            ),
            SizedBox(
              height: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(),
                GestureDetector(
                  onTap: () => takePhoto(context),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      CommonSizes.hSmallSpace,
                      Text(
                        "إلتقط صورة",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.9), fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () => pickImage(context),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      CommonSizes.hSmallSpace,
                      Text(
                        "إختر من المعرض",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.9), fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
