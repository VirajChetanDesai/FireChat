import 'package:flutter/material.dart';
import 'package:firechat/screens/login_screen.dart';
import 'package:firechat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'ButtonandInput.dart';
class WelcomeScreen extends StatefulWidget {
  static String id = 'Welcome_Screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;
  late Animation animation2;
  late Animation animation3;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation2 = ColorTween(begin: Colors.deepOrange , end: Colors.white).animate(controller);
    animation3 = ColorTween(begin: Colors.white,end: Colors.deepOrange).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {
      });
    });
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation3.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0,0,30,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: animation.value * 40,
                      child: Center(child: Image.asset('images/logo.png')),
                    ),
                  ),
                  SizedBox(
                    child: DefaultTextStyle(
                      style : TextStyle(
                        fontSize: 40.0 * animation.value,
                        fontWeight: FontWeight.bold,
                        color: animation2.value,
                        letterSpacing: 1,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts : [TypewriterAnimatedText('FireChat',curve: Curves.bounceInOut),],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: Hero(
                tag: 'Login',
                child: LogButton((){Navigator.pushNamed(context,LoginScreen.id);},'Log In',Colors.orangeAccent),
              ),
            ),
            Flexible(
              child: Hero(
                tag: 'Register',
                child: LogButton(() {Navigator.pushNamed(context, RegistrationScreen.id);},'Register',Colors.deepOrange.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
