import 'package:crossflow_mobile/auth/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final regEmailController = TextEditingController();
  final regPasswordController = TextEditingController();
  final regRePasswordController = TextEditingController();

  bool _regEmailValidateValue = false;
  bool _regPasswValidateValue = false;
  bool _regRePasswValidateValue = false;
  bool _regRePasswValidateValueNotMatch = false;
  bool _regPasswTooShort = false;
  bool _emailInUse = false;

  void signUpUser(String emailVal, String passwVal) async {
    final _auth = AuthServices();

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
      await _auth.signUpWithEmailPassword(
          regEmailController.text, regPasswordController.text);
      Get.back();
      Get.back();
    } catch (e) {
      if (e.toString() == 'weak-password') {
        print('Ez a hiba: The password provided is too weak.');
      } else if (e.toString() == 'email-already-in-use') {
        Get.back();
        setState(() {
          _emailInUse = true;
        });
        print('Ez a hiba: The account already exists for that email.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      child: SvgPicture.asset(
                        "lib/img/icons/user-plus.svg",
                        height: 35,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Regisztrálás",
                      style: TextStyle(fontSize: 32),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                    onTap: () {
                      setState(() {
                        _regEmailValidateValue = false;
                        _emailInUse = false;
                      });
                    },
                    controller: regEmailController,
                    decoration: InputDecoration(
                        errorText: _regEmailValidateValue
                            ? "A mező nem lehet üres"
                            : null,
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
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
                        _regPasswValidateValue = false;
                        _regPasswTooShort = false;
                      });
                    },
                    controller: regPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        errorText: _regPasswValidateValue
                            ? "A mező nem lehet üres"
                            : _regPasswTooShort
                                ? "A jelszónak legalább 8 karakternek kell lennie"
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
                child: TextField(
                    onTap: () {
                      setState(() {
                        _regRePasswValidateValue = false;
                        _regRePasswValidateValueNotMatch = false;
                      });
                    },
                    onChanged: (val) {
                      if (val == regPasswordController.text) {
                        setState(() {
                          _regRePasswValidateValueNotMatch = false;
                        });
                      }
                    },
                    controller: regRePasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        errorText: _regRePasswValidateValue
                            ? "A mező nem lehet üres"
                            : _regRePasswValidateValueNotMatch
                                ? "A jelszavak nem egyeznek"
                                : null,
                        hintText: "Jelszó megerősítése",
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
                        if (fieldsValidator()) {
                          signUpUser(regEmailController.text,
                              regPasswordController.text);
                        } else {
                          print("Nem lehet regisztrálni");
                        }
                      },
                      child: Text(
                        "Regisztráció",
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
                visible: _emailInUse,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Ehez az email címhez már tartozik fiók",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  bool fieldsValidator() {
    //checks, that fields aren't empty
    if (regEmailController.text.isEmpty ||
        regPasswordController.text.isEmpty ||
        regRePasswordController.text.isEmpty) {
      if (regEmailController.text.isEmpty) {
        setState(() {
          _regEmailValidateValue = true;
        });
      }
      if (regPasswordController.text.isEmpty) {
        setState(() {
          _regPasswValidateValue = true;
        });
      }
      if (regRePasswordController.text.isEmpty) {
        setState(() {
          _regRePasswValidateValue = true;
        });
      }
      return false;
    }

    if (regPasswordController.text.length < 8) {
      setState(() {
        _regPasswTooShort = true;
      });
      return false;
    }

    //checks, that the two password fields have the same content
    if (regPasswordController.text != regRePasswordController.text) {
      setState(() {
        _regRePasswValidateValueNotMatch = true;
      });
      return false;
    }
    //passed all tests
    return true;
  }
}
