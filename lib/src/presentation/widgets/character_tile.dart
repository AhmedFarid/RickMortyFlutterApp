import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_morty_app/src/domain/entities/character.dart';

class CharacterTile extends StatelessWidget {
  final Character c;
  const CharacterTile({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(c.imageUrl),
      ),
      title: Text(c.name),
      subtitle: Text('${c.species} • ${c.status}'),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}