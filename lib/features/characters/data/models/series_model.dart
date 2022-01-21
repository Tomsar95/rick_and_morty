import 'package:rick_and_morty/features/characters/domain/entities/series.dart';

class SeriesModel extends Series {
  const SeriesModel({required int numberOfEpisodes})
      : super(numberOfEpisodes: numberOfEpisodes);

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(
      numberOfEpisodes: json['count'],
    );
  }
}

