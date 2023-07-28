import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:option_chain_list/bloc/option_chain_bloc.dart';
import 'package:option_chain_list/constants/constants.dart';
import 'package:option_chain_list/model/option_chain_response.dart';
import 'package:option_chain_list/repository/option_chain_data.dart';
import 'package:option_chain_list/widgets/option_chain_layout.dart';
import 'package:option_chain_list/widgets/option_chain_title_widget.dart';
import 'package:option_chain_list/widgets/spot_price_common_widget.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int positionIndex= -1;
  var searchedValue='';
  double height = 0;
  OptionChainBloc optionChainBloc = OptionChainBloc();
  ValueNotifier<int> firstVisibleItem = ValueNotifier<int>(0);
  ValueNotifier<int> lastVisibleItem = ValueNotifier<int>(0);

  @override
  void initState() {
    // TODO: implement initState
    optionChainBloc.add(FetchOptionChainData());
    _controller.addListener(_scrollListener);
    super.initState();
  }

  var  option = OptionChainResponse.fromJson(Response.response );
  final ScrollController _controller = ScrollController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => optionChainBloc,
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text(widget.title),
              bottom: AppBar(
                toolbarHeight: 50,
                title: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.white,
                        child: Center(
                          child: BlocBuilder<OptionChainBloc, OptionChainState>(
                              builder: (context, state) {
                                double pos = 60;
                                if (state is PositionState) {
                                  pos = pos * state.pos;
                                  positionIndex = state.pos;
                                  if (pos != -1) {
                                    _controller.animateTo(
                                      pos + state.bias,
                                      curve: Curves.easeOut,
                                      duration: const Duration(milliseconds: 300),
                                    );
                                  }
                                }
                                return Container(
                                  color: Colors.black,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          onSubmitted: (value) {
                                            searchedValue = value;
                                            optionChainBloc.add(FetchPosition(v: value));
                                          },
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor: Colors.black,
                                            hintText: Constants.search,
                                            hintStyle: TextStyle(color: Colors.grey),),
                                          style: const TextStyle(color: Colors.white),
                                          // suffixIcon: Icon(Icons.search),suffixIconColor: Colors.white),
                                        ),
                                      ),

                                      const Icon(Icons.search, color: Colors.white,)
                                    ],
                                  ),
                                );
                              }),
                        ))
                  ],
                ),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 39),
                    child: optionChainLayout(
                         _controller,
                         option,
                         context,
                         positionIndex,
                         searchedValue)
                ),
                const OptionChainTitleWidget(),
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: _spotPriceTopView(context,searchedValue),
                    )),
                Align(alignment : Alignment.bottomCenter,
                    child: _spotPriceBottomView(context,searchedValue))
              ],
            )
        ));
  }

  _scrollListener() {
    int itemCount = option.strikes.length;
    double? scrollOffset = _controller.position.pixels;
    double? viewportHeight = _controller.position.viewportDimension;
    double? scrollRange = (_controller.position.maxScrollExtent) -
        (_controller.position.minScrollExtent);
    lastVisibleItem.value = (((scrollOffset) + (viewportHeight)) /
        (scrollRange + (viewportHeight)) * itemCount).floor();
    firstVisibleItem.value =
        (((scrollOffset)) / (scrollRange + (viewportHeight)) * itemCount)
            .floor();
  }



  ValueListenableBuilder<int> _spotPriceBottomView(BuildContext context, String searchedValue) {
    return ValueListenableBuilder<int>(
        valueListenable: lastVisibleItem,
        builder: (context, value, _) {
          if (value <= positionIndex && value !=0 && searchedValue.isNotEmpty) {
            return spotPriceWidget( context,  searchedValue);
          } else {
            return Container();
          }
        });
  }

  ValueListenableBuilder<int> _spotPriceTopView(BuildContext context, String searchedValue) {
    return ValueListenableBuilder<int>(
        valueListenable: firstVisibleItem,
        builder: (context, value, _) {
          if (value >= positionIndex && value != 0 && positionIndex != -1 && searchedValue.isNotEmpty) {
            return  spotPriceWidget( context,  searchedValue);
          } else {
            return Container();
          }
        });
  }

}
