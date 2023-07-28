part of 'option_chain_bloc.dart';

abstract class OptionChainState extends Equatable {
  const OptionChainState();
  
  @override
  List<Object> get props => [];
}

class OptionChainInitial extends OptionChainState {}


class PositionState extends OptionChainState {
  final int pos;
  final int bias;
  const PositionState({required this.pos,required this.bias});
}

class OptionChainError extends OptionChainState {
  final String msg;
  const OptionChainError({required this.msg});
}
