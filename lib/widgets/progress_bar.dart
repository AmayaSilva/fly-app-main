import 'package:flutter/material.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 12),
    // ignore: prefer_const_constructors
    child: CircularProgressIndicator(
      // ignore: prefer_const_constructors
      valueColor: AlwaysStoppedAnimation(
        const Color(0XFF212D4F),
      ),
    ),
  );
}
