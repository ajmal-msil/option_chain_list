import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:option_chain_list/model/option_chain_response.dart';
import 'package:option_chain_list/repository/option_chain_data.dart';

part 'option_chain_event.dart';
part 'option_chain_state.dart';

class OptionChainBloc extends Bloc<OptionChainEvent, OptionChainState> {

  OptionChainBloc() : super(OptionChainInitial()) {
    on<OptionChainEvent>((event, emit) {
      if (event is FetchPosition) {
        emit(OptionChainInitial());
        try {
          var option = OptionChainResponse.fromJson(Response.response);
          int biasPos = 0;
          for (int i = 0 ; i< option.strikes.length ; i++) {
            if( option.strikes.elementAt(i).value.compareTo(event.v) == 0){
              emit(PositionState(pos: i, bias: 0,));
            }
            else {
              if(double.parse(option.strikes.elementAt(i).value ) < double.parse(event.v)){
                biasPos = i;
                if(double.parse(option.strikes.elementAt(i+1).value ) > double.parse(event.v)){
                  emit(PositionState(pos: biasPos+1, bias: 10,));
                }
              }
            }
          }
          emit(const PositionState(pos: -1, bias: 0));
        } catch (e) {
          emit(OptionChainError(msg: e.toString()));
        }
      }    });
  }
}
