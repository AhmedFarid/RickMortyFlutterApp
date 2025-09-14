import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_morty_app/app.dart';
import 'package:rick_morty_app/src/domain/entities/character.dart';

class CharacterDetailsPage extends StatelessWidget {
  final Character character;
  const CharacterDetailsPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
   final c = character;
   return Scaffold(
     appBar: AppBar(title: Text(c.name)),
     body: SingleChildScrollView(
       padding: const EdgeInsets.all(16),
       child: Column(
         children: [
           ClipRRect(
             borderRadius: BorderRadius.circular(16),
             child: Image(image: CachedNetworkImageProvider(c.imageUrl), height: 220, fit: BoxFit.cover),
           ),
           const SizedBox(height: 16),
           ListTile(title: const Text('Status'), subtitle: Text(c.status)),
           ListTile(title: const Text('Species'), subtitle: Text(c.species)),
           ListTile(title: const Text('Origin'), subtitle: Text(c.origin)),
           ListTile(title: const Text('Location'), subtitle: Text(c.location)),
           ListTile(title: const Text('Episodes'), subtitle: Text('${c.episodesCount}')),
         ],
       ),
     ),
   );
  }
}