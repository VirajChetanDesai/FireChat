import 'package:flutter/material.dart';

class LogButton extends StatelessWidget {
  Color color;
  VoidCallback function;
  String name;
  LogButton(this.function,this.name,this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: function,
          minWidth: 200.0,
          height: 60.0,
          child: Text(
            name,
          ),
        ),
      ),
    );
  }
}

class InputDec extends StatelessWidget {
  Function(String) function;
  String message;
  bool password;
  InputDec(this.function,this.message,[this.password = false]);
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: password? TextInputType.text : TextInputType.emailAddress,
      textAlign: TextAlign.center,
      onChanged: function,
      obscureText: password,
      style: const TextStyle(color: Colors.black,),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: message,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.yellow, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }
}

