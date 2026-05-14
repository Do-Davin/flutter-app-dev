import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const String getCharacters = r'''
  query GetCharacters($page: Int!) {
    characters(page: $page) {
      info {
        count
        pages
        next
      }
      results {
        id
        name
        status
        species
        image
      }
    }
  }
''';

class GraphqlScreen extends StatefulWidget {
  const GraphqlScreen({super.key});

  @override
  State<GraphqlScreen> createState() {
    return _GraphqlScreenState();
  }
}

class _GraphqlScreenState extends State<GraphqlScreen> {
  int _page = 1;
  bool _loading = false;
  String _errorMessage = '';
  List<dynamic> _characters = [];
  bool _hasNextPage = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadCharacters();
    });
  }

  Future<void> _loadCharacters() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      GraphQLClient client = GraphQLProvider.of(context).value;

      QueryResult result = await client.query(
        QueryOptions(
          document: gql(getCharacters),
          variables: {'page': _page},
          fetchPolicy: FetchPolicy.noCache,
        ),
      );

      if (!mounted) {
        return;
      }

      if (result.hasException) {
        setState(() {
          _loading = false;
          _errorMessage = result.exception.toString();
        });
        return;
      }

      Map<String, dynamic> data = result.data ?? {};
      Map<String, dynamic> charactersData = data['characters'] ?? {};
      Map<String, dynamic> info = charactersData['info'] ?? {};

      setState(() {
        _characters = charactersData['results'] ?? [];
        _hasNextPage = info['next'] != null;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _errorMessage = error.toString();
      });
    }
  }

  void _goToNextPage() {
    setState(() {
      _page++;
    });

    _loadCharacters();
  }

  Widget _buildCharacterItem(Map<String, dynamic> character) {
    String name = character['name'];
    String status = character['status'];
    String species = character['species'];
    String image = character['image'];

    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(image)),
        title: Text(name),
        subtitle: Text('$status - $species'),
      ),
    );
  }

  Widget _buildCharacterList(List<dynamic> characters, bool hasNextPage) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> character = characters[index];
              return _buildCharacterItem(character);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
            onPressed: hasNextPage ? _goToNextPage : null,
            child: Text('Next Page ($_page)'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_errorMessage.isNotEmpty) {
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loadCharacters,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    } else if (_characters.isEmpty) {
      body = const Center(child: Text('No characters found.'));
    } else {
      body = _buildCharacterList(_characters, _hasNextPage);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('GraphQL Characters')),
      body: SafeArea(child: body),
    );
  }
}
