import 'package:flutter/material.dart';
import 'package:option_chain_list/constants/constants.dart';
import 'package:option_chain_list/model/option_chain_response.dart';
import 'package:option_chain_list/widgets/strike_price_widget.dart';

List<Widget> optionChainCells(
    Color? bg,
    OptionChainResponse option,
    String type,
    int currentIndex,
    BuildContext context,
    int positionIndex,
    String searchedValue) {
  List<String> values = [];
  if (type == Constants.put) {
    values.add(option.strikes.elementAt(currentIndex).put.change);
    values.add(option.strikes.elementAt(currentIndex).put.oi);
    values.add(option.strikes.elementAt(currentIndex).put.ltp);
  } else if (type == Constants.call) {
    values.add(option.strikes.elementAt(currentIndex).call.ltp);
    values.add(option.strikes.elementAt(currentIndex).call.oi);
    values.add(option.strikes.elementAt(currentIndex).call.change);
  } else {
    for (var element in option.strikes) {
      values.add(element.value);
    }
  }

  return List.generate(
    values.length,
    (index) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (type != Constants.strike)
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 5,
            height: 60,
            color: bg,
            child: Text(values.elementAt(index),
                style: const TextStyle(color: Colors.white)),
          ),
        if ((type == Constants.strike) && index != positionIndex)
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 3.3,
            height: 60.0,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 5,
              height: 60.0,
              color: bg,
              child: Text(values.elementAt(index),
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
        if (searchedValue.isNotEmpty &&
            type == Constants.strike &&
            index == positionIndex)
          strikePriceWidget(searchedValue == values.elementAt(index),
              values.elementAt(index), bg, context, searchedValue)
      ],
    ),
  );
}
