part of 'option_chain_bloc.dart';

abstract class OptionChainEvent {

}
class FetchOptionChainData extends OptionChainEvent{}

class FetchPosition extends OptionChainEvent{
  String v;
  FetchPosition({required this.v});
}
