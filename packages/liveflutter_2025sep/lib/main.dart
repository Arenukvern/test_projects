/// 1) добавить dio в проект: flutter pub add dio
/// 2) Реализовать LazyLoading по скроллу вниз
/// Ссылка на api docs: https://rickandmortyapi.com/documentation/#rest
library;

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rick & Morty Characters'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
  List<Character> _characters = [];
  final ScrollController _scrollController = ScrollController();
  PageInfo? _pageInfo;

  bool _isNextPageLoading = false;
  bool _hasRequestToLoadNextPage = false;
  static const String _initApi = '/character';
  bool _hasNext = true;

  Future<CharactersResponse> _getCharacters() async {
    try {
      final response = await dio.get(_pageInfo?.next ?? _initApi);
      return CharactersResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _loadMoreCharacters() async {
    if (!_hasNext) return;
    if (_isNextPageLoading) {
      _hasRequestToLoadNextPage = true;
      return;
    }
    _isNextPageLoading = true;

    final characters = await _getCharacters();
    _pageInfo = characters.info;
    if (!mounted) return;
    setState(
      () => _characters = {..._characters, ...characters.results}.toList(),
    );
    if (_pageInfo?.next == null) {
      setState(() => _hasNext = false);
      _hasRequestToLoadNextPage = false;
      _isNextPageLoading = false;
    } else {
      _isNextPageLoading = false;
      if (_hasRequestToLoadNextPage) {
        _hasRequestToLoadNextPage = false;
        unawaited(_loadMoreCharacters());
      }
    }
  }

  void _onScroll() {
    if (!mounted) return;
    if (_scrollController.hasClients) return;
    if (_scrollController.position.atEdge) _loadMoreCharacters();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_loadMoreCharacters());
    });
  }

  @override
  void dispose() {
    dio.close();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _characters.length + 1,
        itemBuilder: (context, index) {
          if (index == _characters.length) {
            if (!_hasNext) return const SizedBox.shrink();
            return const Center(child: CircularProgressIndicator());
          }
          final character = _characters[index];
          final id = character.id;
          final key = ValueKey(id);
          return CharacterVerticalCard(key: key, character: character);
        },
      ),
    );
  }
}

class CharacterVerticalCard extends StatelessWidget {
  const CharacterVerticalCard({super.key, required this.character});
  final Character character;

  Color _statusColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    switch (character.status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return cs.error;
      default:
        return cs.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    color: theme.colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              character.name,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Chip(
                  leading: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _statusColor(context),
                      shape: BoxShape.circle,
                    ),
                  ),
                  label: character.status.isEmpty
                      ? 'unknown'
                      : character.status,
                ),
                if (character.species.isNotEmpty)
                  _Chip(label: character.species),
                if (character.gender.isNotEmpty) _Chip(label: character.gender),
              ],
            ),
            const SizedBox(height: 8),
            if (character.locationName.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.place, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      character.locationName,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({this.leading, required this.label});
  final Widget? leading;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 6)],
          Text(label, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}

class AppConstants {
  static const String baseUrl = 'https://rickandmortyapi.com/api';
}

/// ---------------- MODELS ----------------

class CharactersResponse {
  final PageInfo info;
  final List<Character> results;

  const CharactersResponse({required this.info, required this.results});

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    return CharactersResponse(
      info: PageInfo.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PageInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const PageInfo({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    count: json['count'] as int,
    pages: json['pages'] as int,
    next: json['next'] as String?,
    prev: json['prev'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'count': count,
    'pages': pages,
    'next': next,
    'prev': prev,
  };
}

class Character {
  final int id;
  final String name;
  final String image;
  final String status;
  final String species;
  final String gender;
  final String locationName;

  const Character({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.species,
    required this.gender,
    required this.locationName,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
    id: json['id'] as int,
    name: json['name'] as String,
    image: json['image'] as String,
    status: (json['status'] as String?) ?? '',
    species: (json['species'] as String?) ?? '',
    gender: (json['gender'] as String?) ?? '',
    locationName: ((json['location'] as Map?)?['name'] as String?) ?? '',
  );
}
