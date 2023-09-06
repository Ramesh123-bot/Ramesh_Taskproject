import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RepositoryList(),
    );
  }
}

class RepositoryList extends StatefulWidget {
  const RepositoryList({super.key});

  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  List<GitHubRepository> repositories = [];

  @override
  void initState() {
    super.initState();
    fetchRepositories();
  }

  Future<void> fetchRepositories() async {
    final response = await http.get(
      Uri.parse(
        'https://api.github.com/search/repositories?q=created:>2022-07-05&sort=stars&order=desc',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      setState(() {
        repositories = items.map((item) {
          return GitHubRepository(
            name: item['name'] ?? '',
            description: item['description'] ?? '',
            stars: item['stargazers_count'] ?? 0,
            ownerUsername: item['owner']['login'] ?? '',
            ownerAvatarUrl: item['owner']['avatar_url'] ?? '',
          );
        }).toList();
      });
    } else {
      throw Exception('Failed to load repositories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramesh GitHub'),
      ),
      body: ListView.builder(
        itemCount: repositories.length,
        itemBuilder: (context, index) {
          final repository = repositories[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(repository.ownerAvatarUrl),
            ),
            title: Text(repository.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(repository.description),
                Text('Stars: ${repository.stars}'),
              ],
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}

class GitHubRepository {
  final String name;
  final String description;
  final int stars;
  final String ownerUsername;
  final String ownerAvatarUrl;

  GitHubRepository({
    required this.name,
    required this.description,
    required this.stars,
    required this.ownerUsername,
    required this.ownerAvatarUrl,
  });
}
