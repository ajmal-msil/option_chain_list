import 'package:flutter/material.dart';
import 'package:option_chain_list/model/option_chain_response.dart';
import 'package:option_chain_list/widgets/option_chain_coloumn_cell.dart';

List<Widget> optionChainRowCell(
    Color bg,
    OptionChainResponse option,
    String type,
    BuildContext context,
    int positionIndex,
    String searchedValue) {
  return List.generate(
    option.strikes.length,
    (index) => Row(
      children: optionChainCells(
          bg, option, type, index, context, positionIndex, searchedValue),
    ),
  );
}
