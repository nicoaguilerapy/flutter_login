import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _BlueBox(),
          SafeArea(
            child: Container(
              width: double.infinity,
              child: Icon(
                Icons.person_pin,
                color: Colors.white,
                size: 100,
              ),
              margin: EdgeInsets.only(top: 30),
            ),
          ),
          this.child,
        ],
      ),
    );
  }
}

class _BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      color: Colors.indigoAccent,
    );
  }
}
