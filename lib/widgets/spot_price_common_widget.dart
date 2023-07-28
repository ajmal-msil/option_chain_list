import 'package:flutter/material.dart';

Widget spotPriceWidget(BuildContext context, String searchedValue) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0), color: Colors.grey),
    alignment: Alignment.center,
    width: (MediaQuery.of(context).size.width / 5) * 1.5,
    height: 35,
    child: Text('Spot Price:$searchedValue',
        style: const TextStyle(color: Colors.white)),
  );
}
