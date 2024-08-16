import 'package:al_dalel/layers/view/screens/auth/widgets/gradient_button.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/configuration/styles.dart';
import '../../../../core/loaders/loading_overlay.dart';
import '../../../../core/routing/route_path.dart';
import '../../../../core/shared_preferences/shared_preferences_instance.dart';
import '../../../../core/shared_preferences/shared_preferences_key.dart';
import '../../../../core/validators/validators.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _password = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  logIn() async {
    LoadingOverlay.of(context).show();

    if (_emailController.text.trim().isNotEmpty &&
        _password.text.trim().isNotEmpty) {
      await Future.wait([
        SharedPreferencesInstance.pref.setInt(SharedPreferencesKeys.USER_ID, 1),
        SharedPreferencesInstance.pref
            .setString(SharedPreferencesKeys.FIRST_NAME, "Ahmed"),
        SharedPreferencesInstance.pref.setString(
            SharedPreferencesKeys.EMAIL, _emailController.text.trim()),
      ]);
      await Future.delayed(Duration(seconds: 2), () {
        LoadingOverlay.of(context).hide();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(RoutePaths.Home, (_) => false);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsetsDirectional.only(top: 60.0, start: 22),
                child: Text(
                  'مرحباً \nتسجيل الدخول!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              CommonSizes.vSmallerSpace,
                              const TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.check,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      'البريد الإلكتروني',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffB81736),
                                      ),
                                    )),
                              ),
                              const TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      'كلمة المرور',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffB81736),
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'نسيت كلمة المرور ؟',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color(0xff281537),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                height: 55,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffB81736),
                                    Color(0xff281537),
                                  ]),
                                ),
                                child: const Center(
                                  child: Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              CommonSizes.vSmallerSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "لا تملك حساب ؟",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            RoutePaths.SignUp, (_) => false),
                                    child: Text(
                                      "أنشأ حساب",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
