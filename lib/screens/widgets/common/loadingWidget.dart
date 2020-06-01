import 'package:flutter/material.dart';

Widget loadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 25.0,
        width: 25.0,
        child: CircularProgressIndicator(
          strokeWidth: 4.0,
        ),
      )
    ],
  ));
}
