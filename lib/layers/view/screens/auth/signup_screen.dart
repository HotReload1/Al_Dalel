import 'package:al_dalel/core/loaders/loading_overlay.dart';
import 'package:al_dalel/core/routing/route_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/configuration/styles.dart';
import '../../../../core/shared_preferences/shared_preferences_instance.dart';
import '../../../../core/shared_preferences/shared_preferences_key.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  signUp() async {
    LoadingOverlay.of(context).show();

    await Future.wait([
      SharedPreferencesInstance.pref.setInt(SharedPreferencesKeys.USER_ID, 1),
      SharedPreferencesInstance.pref.setString(
          SharedPreferencesKeys.FIRST_NAME, _fullNameController.text.trim()),
      SharedPreferencesInstance.pref
          .setString(SharedPreferencesKeys.EMAIL, _emailController.text.trim()),
    ]);
    await Future.delayed(Duration(seconds: 2), () {
      LoadingOverlay.of(context).hide();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RoutePaths.Home, (_) => false);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _password.dispose();
    _confirmPassword.dispose();
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
                  'مرحباً \nإنشاء حساب!',
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              CommonSizes.vSmallerSpace,
                              TextField(
                                controller: _fullNameController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.check,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      'الإسم كامل',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffB81736),
                                      ),
                                    )),
                              ),
                              CommonSizes.vSmallerSpace,
                              TextField(
                                controller: _emailController,
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
                              CommonSizes.vSmallerSpace,
                              TextField(
                                controller: _password,
                                style: TextStyle(color: Colors.black),
                                obscureText: true,
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
                              CommonSizes.vSmallerSpace,
                              TextField(
                                controller: _confirmPassword,
                                style: TextStyle(color: Colors.black),
                                obscureText: true,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      'تأكيد كلمة المرور',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffB81736),
                                      ),
                                    )),
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => signUp(),
                                child: Container(
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
                                      'تسجيل',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              CommonSizes.vSmallerSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "لديك حساب؟",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            RoutePaths.LogIn, (_) => false),
                                    child: Text(
                                      "تسجيل الدخول",
                                      style: TextStyle(

                                          ///done login page
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
