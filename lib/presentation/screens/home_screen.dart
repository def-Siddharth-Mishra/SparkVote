import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/models/idea_model.dart';
import '../providers/idea_provider.dart';
import '../widgets/idea_card.dart';
import '../widgets/theme_switch.dart';
import 'idea_submission_screen.dart';
import 'leaderboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch ideas when the screen is first loaded.
    // `listen: false` is used because we are in initState.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<IdeaProvider>().fetchIdeas();
    });
  }

  void _onShare(Idea idea) {
    final shareText =
        'Check out this startup idea: *${idea.name}*!\n\nTagline: ${idea.tagline}\n\nIt has an AI rating of ${idea.rating} and ${idea.votes} votes!';
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Ideas'),
        actions: [
          _buildSortMenu(),
          IconButton(
            icon: const Icon(Icons.leaderboard_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
            ),
          ),
          const ThemeSwitch(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<IdeaProvider>().fetchIdeas(),
        child: Consumer<IdeaProvider>(
          builder: (context, provider, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildBody(provider),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const IdeaSubmissionScreen()),
        ),
        label: const Text('New Idea'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSortMenu() {
    return Consumer<IdeaProvider>(
      builder: (context, provider, child) {
        return PopupMenuButton<SortOption>(
          onSelected: (option) => provider.setSortOption(option),
          icon: const Icon(Icons.sort),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: SortOption.votes,
              child: Text(
                'Sort by Votes',
                style: TextStyle(
                  fontWeight: provider.sortOption == SortOption.votes
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            PopupMenuItem(
              value: SortOption.rating,
              child: Text(
                'Sort by Rating',
                style: TextStyle(
                  fontWeight: provider.sortOption == SortOption.rating
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBody(IdeaProvider provider) {
    switch (provider.state) {
      case ViewState.loading:
        return const Center(
          key: ValueKey('loading'),
          child: CircularProgressIndicator(),
        );
      case ViewState.error:
        return const Center(
          key: ValueKey('error'),
          child: Text('Failed to load ideas.'),
        );
      case ViewState.idle:
        if (provider.ideas.isEmpty) {
          return const Center(
            key: ValueKey('empty'),
            child: Text('No ideas yet. Be the first!'),
          );
        }
        return ListView.builder(
          key: const ValueKey('list'),
          padding: const EdgeInsets.all(8.0),
          itemCount: provider.ideas.length,
          itemBuilder: (context, index) {
            final idea = provider.ideas[index];
            return IdeaCard(
              idea: idea,
              onVote: () => provider.voteForIdea(idea.id),
              onShare: () => _onShare(idea),
            );
          },
        );
    }
  }
}
