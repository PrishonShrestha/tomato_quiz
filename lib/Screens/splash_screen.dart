import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFEFEFE),
      child: Center(
        child: Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://cdn.dribbble.com/users/4941866/screenshots/10815342/media/f3629d9fc86183e9f7571bdfb8919077.gif")
            )
          ),
        ),
      ),
    );
  }
}
