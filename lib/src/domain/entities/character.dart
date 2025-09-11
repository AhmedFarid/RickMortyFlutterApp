import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String imageUrl;
  final String origin;
  final String location;
  final int episodesCount;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.imageUrl,
    required this.origin,
    required this.location,
    required this.episodesCount,
});

  @override
  List<Object?> get props => [id, name, status, species, imageUrl, origin, location, episodesCount];
}