import 'dart:io';
import 'package:al_dalel/core/configuration/assets.dart';
import 'package:al_dalel/core/routing/route_path.dart';
import 'package:al_dalel/layers/view/screens/profile/widgets/settings_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared_preferences/shared_preferences_instance.dart';
import '../../../../core/shared_preferences/shared_preferences_key.dart';
import '../../../../core/ui/warning_dialog.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "الملف الشخصي",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        height: 100,
                        width: 100,
                        child: ClipOval(
                            child: Image.asset(AssetsLink.PROFILE_IMAGE))),
                    // provider.currentUser != null &&
                    //         provider.currentUser!.imageUrl != null
                    //     ? Container(
                    //         margin: EdgeInsets.symmetric(horizontal: 16),
                    //         height: 100,
                    //         width: 100,
                    //         child: ClipOval(
                    //           child: CachedNetworkImage(
                    //             imageUrl:
                    //                 provider.currentUser!.imageUrl.toString(),
                    //             fit: BoxFit.cover,
                    //             alignment: Alignment.topCenter,
                    //             placeholder: (context, url) =>
                    //                 CircularProgressIndicator(
                    //               color: Colors.red,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : SizedBox()
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Ahmed",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 25,
                ),
                settingsCategory("الإعدادات", [
                  SettingsCard(
                      icon: Icons.settings,
                      title: "إعدادات التطبيق",
                      function: () {})
                ]),
                SizedBox(
                  height: 20,
                ),
                settingsCategory("الحساب", [
                  SettingsCard(
                      icon: Icons.person,
                      title: "تعديل اسم الحساب",
                      function: () {}),
                  SettingsCard(
                      icon: Icons.lock,
                      title: "تعديل كلمة المرور",
                      function: () {}),
                  SettingsCard(
                      icon: Icons.image,
                      title: "تعديل صورة الحساب",
                      function: () => {}),
                ]),
                SizedBox(
                  height: 20,
                ),
                settingsCategory("دليل", [
                  SettingsCard(
                      icon: Icons.people, title: "من نحن", function: () {}),
                  SettingsCard(icon: Icons.info, title: "FAQ", function: () {}),
                  SettingsCard(
                      icon: Icons.electric_bolt,
                      title: "المساعدة",
                      function: () {}),
                  SettingsCard(
                      icon: Icons.thumb_up, title: "إدعمنا", function: () {}),
                ]),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    final res = await showDialog<bool?>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) => WarningDialog(
                              message: '${"هل أنت متأكد!"}',
                              isWithButton: true,
                              isWithWarningLogo: true,
                            ));
                    if (res != null && res) {
                      await Future.wait([
                        SharedPreferencesInstance.pref
                            .remove(SharedPreferencesKeys.USER_ID),
                        SharedPreferencesInstance.pref
                            .remove(SharedPreferencesKeys.FIRST_NAME),
                        SharedPreferencesInstance.pref
                            .remove(SharedPreferencesKeys.EMAIL),
                      ]);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          RoutePaths.WelcomeScreen, (_) => false);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "تسجيل الخروج",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column settingsCategory(String title, List<SettingsCard> cards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
        ),
        SizedBox(
          height: 15,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cards.length,
          separatorBuilder: (context, index) => SizedBox(
            height: 15,
          ),
          itemBuilder: (context, index) {
            return cards[index];
          },
        ),
      ],
    );
  }

  Container tasksNumber(String text) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(4)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
