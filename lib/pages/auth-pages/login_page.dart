import 'package:crossflow_mobile/auth/auth_services.dart';
import 'package:crossflow_mobile/pages/auth-pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class login_page extends StatefulWidget {
  login_page({
    super.key,
  });

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  //text controller for login
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //text controller for register
  final regEmailController = TextEditingController();
  final regPasswordController = TextEditingController();

  bool _emailValidateValue = false;
  bool _passwValidateValue = false;

  bool _regEmailValidateValue = false;
  bool _regPasswValidateValue = false;

  bool _wrongCredentials = false;

  void signInUser(BuildContext context) async {
    final authServices = AuthServices();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SpinKitDoubleBounce(
            color: Colors.white,
            size: 50.0,
          );
        });

    try {
      await authServices.signInWithEmailPassword(
          emailController.text, passwordController.text);
      Get.back();
      Get.back();
    } catch (e) {
      print("Ez a hiba: " + e.toString());
      Get.back();
      if (e.toString() == "invalid-credential" ||
          e.toString() == "invalid-email") {
        passwordController.clear();
        setState(() {
          _wrongCredentials = true;
        });
        /*Get.snackbar(
            backgroundColor: Theme.of(context).colorScheme.onError,
            icon: Icon(Icons.warning),
            "Hiba",
            "Helytelen email vagy jelszó!");*/
      } else if (e.toString() == "network-request-failed") {
        /*Get.snackbar(
            backgroundColor: Theme.of(context).colorScheme.onError,
            icon: Icon(Icons.wifi_off),
            "Hiba",
            "Nem vagy csatlakozva az internethez");*/
      }
    }

    /*try {
      
      Get.back();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      Get.back();
      if (e.code == "invalid-credential" || e.code == "invalid-email") {
        passwordController.clear();
        Get.snackbar(
            backgroundColor: Theme.of(context).colorScheme.onError,
            icon: Icon(Icons.warning),
            "Hiba",
            "Helytelen email vagy jelszó!");
      } else if (e.code == "network-request-failed") {
        Get.snackbar(
            backgroundColor: Theme.of(context).colorScheme.onError,
            icon: Icon(Icons.wifi_off),
            "Hiba",
            "Nem vagy csatlakozva az internethez");
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: SvgPicture.asset(
                    "lib/img/logo_self_white.svg",
                    height: 80,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                    onTap: () {
                      setState(() {
                        _emailValidateValue = false;
                      });
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        errorText: _emailValidateValue
                            ? "A mező nem lehet üres"
                            : null,
                        hintText: "Email",
                        fillColor: Theme.of(context).colorScheme.secondary,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                    onTap: () {
                      setState(() {
                        _passwValidateValue = false;
                        _wrongCredentials = false;
                      });
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        errorText: _passwValidateValue
                            ? "A mező nem lehet üres"
                            : null,
                        hintText: "Jelszó",
                        prefixIcon: Icon(Icons.password_outlined),
                        fillColor: Theme.of(context).colorScheme.secondary,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                    width: double.maxFinite,
                    height: 60,
                    child: FilledButton(
                      onPressed: () {
                        setState(() {
                          _emailValidateValue = emailController.text.isEmpty;
                          _passwValidateValue = passwordController.text.isEmpty;
                        });
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          signInUser(context);
                        }
                      },
                      child: Text(
                        "Bejelentkezés",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                            fontSize: 24),
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor)),
                    )),
              ),
              Visibility(
                visible: _wrongCredentials,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "A megadott email vagy jelszó helytelen!",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(children: <Widget>[
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("vagy"),
                  ),
                  Expanded(child: Divider()),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                    width: double.maxFinite,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => RegisterPage());
                      },
                      child: Text(
                        "Új fiók létrehozása",
                        style: TextStyle(fontSize: 24),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
