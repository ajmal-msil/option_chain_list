import 'package:flutter/material.dart';
import 'package:option_chain_list/widgets/spot_price_common_widget.dart';

Widget strikePriceWidget(bool isMatching , String value , bg,BuildContext context,String searchedValue){
  if(isMatching) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 5,
            height: 60.0,
            color: bg,
            child: Text(searchedValue,
                style: const TextStyle(color: Colors.white)),
          ),
        ),
        spotPriceWidget( context,  searchedValue)
      ],
    );
  }else {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 5,
          height: 60.0,
          color: bg,
          child: Text(value,
              style: const TextStyle(color: Colors.white)),
        ),
        spotPriceWidget( context,  searchedValue)
      ],
    );
  }
}
