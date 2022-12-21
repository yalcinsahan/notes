import 'package:flutter/material.dart';

class Sizes {
  static perWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.01;
  static perHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.01;
}
