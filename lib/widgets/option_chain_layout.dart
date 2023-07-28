import 'package:flutter/material.dart';
import 'package:option_chain_list/constants/constants.dart';
import 'package:option_chain_list/model/option_chain_response.dart';
import 'package:option_chain_list/widgets/option_chain_coloumn_cell.dart';
import 'package:option_chain_list/widgets/option_chain_row_cell.dart';

Widget optionChainLayout(
    ScrollController controller,
    OptionChainResponse option,
    BuildContext context,
    int positionIndex,
    String searchedValue) {
  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          controller: controller,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: optionChainRowCell(Colors.black, option,
                        Constants.put, context, positionIndex, searchedValue),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: optionChainCells(Colors.lightGreen[900], option,
                    Constants.strike, 0, context, positionIndex, searchedValue),
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: optionChainRowCell(Colors.black, option,
                        Constants.call, context, positionIndex, searchedValue),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}
