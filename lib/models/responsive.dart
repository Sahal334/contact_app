import 'package:flutter/material.dart';

double screenHeight(BuildContext context, {double? dividedBy}) {
  return MediaQuery.of(context).size.height / (dividedBy ?? 1);
}

double screenWidth(BuildContext context, {double? dividedBy}) {
  return MediaQuery.of(context).size.width / (dividedBy ?? 1);
}
