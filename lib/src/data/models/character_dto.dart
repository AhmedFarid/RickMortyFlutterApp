class CharacterDto {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final String originName;
  final String locationName;
  final List<dynamic> episode;

  CharacterDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        status = json['status'],
        species = json['species'],
        image = json['image'],
        originName = (json['origin']?['name'] ?? '') as String,
        locationName = (json['location']?['name'] ?? '') as String,
        episode = (json['episode'] as List).toList();

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'status': status, 'species': species,
    'image': image, 'origin': {'name': originName}, 'location': {'name': locationName},
    'episode': episode
  };
}