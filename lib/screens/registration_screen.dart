import 'package:firechat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'ButtonandInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_string';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String name = '';
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
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 150,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                child: InputDec((string) {
                  name = string;
                }, 'Enter your Name.'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
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
              Flexible(
                child: Hero(
                  tag: 'Register',
                  child: LogButton(() async {
                    setState(() {
                      _spinner = true;
                    });
                    try {
                      final new_user = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password,);
                      if (new_user != null) {
                        setState(() {
                          _spinner = false;
                        });
                        await new_user.user?.updateDisplayName(name);
                        await new_user.user?.reload();
                        Navigator.pushNamedAndRemoveUntil(context, ChatScreen.id,
                                (Route<dynamic> route) => false);
                      } else {
                        setState(() {
                          _spinner = false;
                        });
                        throw Future.error('error');
                      }
                    } catch (e) {
                      print(e);
                      Alert(
                        style: const AlertStyle(
                          backgroundColor: Colors.white,
                        ),
                        context: context,
                        type: AlertType.error,
                        title: "SIGN UP FAILED",
                        desc: "Invalid username or password",
                        buttons: [
                          DialogButton(
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                            child: const Text(
                              "REGISTER",
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
                  }, 'Register', Colors.deepOrange.shade800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
