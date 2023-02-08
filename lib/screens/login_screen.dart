import 'package:firechat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'ButtonandInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool _spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: ModalProgressHUD(
        inAsyncCall: _spinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 150.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: InputDec((string) {
                  email = string;
                }, 'Enter your email.'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InputDec((string) {
                  password = string;
                }, 'Enter your password.', true),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Hero(
                tag: 'Login',
                child: LogButton(() async {
                  setState(() {
                    _spinner = true;
                  });
                  try {
                    final old_user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (old_user != null) {
                      setState(() {
                        _spinner = false;
                      });
                      Navigator.pushNamedAndRemoveUntil(context, ChatScreen.id,
                              (Route<dynamic> route) => false);
                    }else{
                      setState(() {
                        _spinner = false;
                      });
                      throw Future.error(old_user);
                    }
                  } catch (e) {
                    print(e);
                      Alert(
                        style: const AlertStyle(
                          backgroundColor: Colors.white,
                        ),
                        context: context,
                        type: AlertType.error,
                        title: "LOG IN FAILED",
                        desc: "Invalid username or password",
                        buttons: [
                          DialogButton(
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                            child: const Text(
                              "LOGIN",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )
                        ],
                      ).show();
                    setState(() {
                      _spinner = false;
                    });
                  }
                }, 'Log In', Colors.orangeAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
