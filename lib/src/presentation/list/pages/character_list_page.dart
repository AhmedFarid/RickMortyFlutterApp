import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/src/presentation/list/bloc/character_list_bloc.dart';
import 'package:rick_morty_app/src/presentation/widgets/character_tile.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final _controller = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final bloc = context.read<CharacterListBloc>();
    if (_controller.position.pixels >= _controller.position.maxScrollExtent - 300) {
      bloc.add(CharactersFetched());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characterpedia')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search characters...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<CharacterListBloc>().add(const CharactersSearched(null));
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (q) => context.read<CharacterListBloc>().add(CharactersSearched(q.trim().isEmpty ? null : q.trim())),
            ),
          ),
          Expanded(
            child: BlocConsumer<CharacterListBloc, CharacterListState>(
              listener: (context, state) {
                if (state.status == ListStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error ?? 'Something went wrong')));
                }
              },
              builder: (context, state) {
                if (state.status == ListStatus.initial || (state.status == ListStatus.loading && state.items.isEmpty)) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == ListStatus.failure && state.items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.error ?? 'Failed to load'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => context.read<CharacterListBloc>().add(CharactersRefreshed()),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async => context.read<CharacterListBloc>().add(CharactersRefreshed()),
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: state.items.length + (state.hasReachedMax ? 0 : 1),
                    itemBuilder: (ctx, i) {
                      if (i >= state.items.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final c = state.items[i];
                      return InkWell(
                        onTap: () => context.push('/character/${c.id}', extra: c),
                        child: CharacterTile(c: c),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}