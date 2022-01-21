import 'package:equatable/equatable.dart';

class Series extends Equatable {
  final int numberOfEpisodes;

  const Series({required this.numberOfEpisodes});

  @override
  List<Object> get props => [];
}