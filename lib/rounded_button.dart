import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String btnText;
  final Function onBtnPressed;

  const RoundedButton(
      {Key? key, required this.btnText, required this.onBtnPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Color.fromARGB(255, 255, 126, 45),
      borderRadius: BorderRadius.circular(5),
      child: MaterialButton(
        onPressed: () {
          onBtnPressed();
        },
        minWidth: 200,
        height: 30,
        child: Text(
          btnText,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontFamily: 'Inter-Bold'),
        ),
      ),
    );
  }
}
