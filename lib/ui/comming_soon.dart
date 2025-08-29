import 'package:flutter/material.dart';

class CommingSoon extends StatelessWidget {
  const CommingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Development in progress...",style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
