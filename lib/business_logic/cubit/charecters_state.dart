part of 'charecters_cubit.dart';

@immutable
abstract class CharectersState {}

class CharectersLoaded extends CharectersState {
  
  final List<Character> characters;
  CharectersLoaded(this.characters);
}


class CharectersInitial extends CharectersState {}



@immutable
abstract class QuotesState {}


class QuotesLoaded extends QuotesState {
  
  final List quotes;
  QuotesLoaded(this.quotes);
}

class QuotesInitial extends QuotesState {}
