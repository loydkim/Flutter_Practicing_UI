import 'package:flutter/material.dart';

class CommonWidgets{
  static Widget loadingCircle(){
    return Positioned(
      child: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
        color: Colors.white.withOpacity(0.7),
      ),
    );
  }
}