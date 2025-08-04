import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/idea_model.dart';
import '../providers/idea_provider.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🏆 Leaderboard')),
      body: Consumer<IdeaProvider>(
        builder: (context, provider, child) {
          final topIdeas = provider.leaderboardIdeas;
          if (topIdeas.isEmpty) {
            return const Center(child: Text('No ideas to rank yet!'));
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: topIdeas.length,
            itemBuilder: (context, index) {
              return _buildLeaderboardCard(topIdeas[index], index, context);
            },
          );
        },
      ),
    );
  }

  Widget _buildLeaderboardCard(Idea idea, int rank, BuildContext context) {
    final colors = [
      Colors.amber.shade600,
      Colors.grey.shade400,
      Colors.brown.shade400,
    ];
    final badges = ['🥇', '🥈', '🥉'];
    final color = rank < 3
        ? colors[rank]
        : Theme.of(context).colorScheme.surfaceVariant;
    final badge = rank < 3 ? badges[rank] : '${rank + 1}';

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 1.5),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: color,
          child: Text(
            badge,
            style: TextStyle(
              fontSize: rank < 3 ? 24 : 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        title: Text(
          idea.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          idea.tagline,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${idea.votes}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text('Votes'),
          ],
        ),
      ),
    );
  }
}
