import 'package:flutter/material.dart';
import 'package:firechat/screens/welcome_screen.dart';
import 'package:firechat/screens/login_screen.dart';
import 'package:firechat/screens/registration_screen.dart';
import 'package:firechat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: _auth.currentUser != null ? ChatScreen.id: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        RegistrationScreen.id : (context) =>  RegistrationScreen(),
      },
    );
  }
}
