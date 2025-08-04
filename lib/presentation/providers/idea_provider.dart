import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/idea_model.dart';
import '../../domain/repositories/idea_repository.dart';

enum SortOption { rating, votes }

enum ViewState { idle, loading, error }

class IdeaProvider with ChangeNotifier {
  final IdeaRepository _repository;

  IdeaProvider(this._repository) {
    fetchIdeas();
  }

  List<Idea> _ideas = [];
  ViewState _state = ViewState.idle;
  SortOption _sortOption = SortOption.votes;

  // --- Getters ---
  List<Idea> get ideas {
    _sortIdeas();
    return _ideas;
  }

  List<Idea> get leaderboardIdeas {
    final sortedByVotes = List<Idea>.from(_ideas)
      ..sort((a, b) => b.votes.compareTo(a.votes));
    return sortedByVotes.take(5).toList();
  }

  ViewState get state => _state;
  SortOption get sortOption => _sortOption;

  // --- Public Methods ---
  Future<void> fetchIdeas() async {
    _setState(ViewState.loading);
    try {
      _ideas = await _repository.getIdeas();
      _setState(ViewState.idle);
    } catch (e) {
      _setState(ViewState.error);
    }
  }

  Future<void> submitIdea({
    required String name,
    required String tagline,
    required String description,
  }) async {
    final newIdea = Idea(
      id: const Uuid().v4(),
      name: name,
      tagline: tagline,
      description: description,
      rating: _generateAIRating(),
    );
    await _repository.saveIdea(newIdea);
    await fetchIdeas(); // Refresh the list
  }

  Future<void> voteForIdea(String ideaId) async {
    final ideaIndex = _ideas.indexWhere((i) => i.id == ideaId);
    if (ideaIndex != -1) {
      final idea = _ideas[ideaIndex];
      if (!idea.hasVoted) {
        final updatedIdea = idea.copyWith(
          votes: idea.votes + 1,
          hasVoted: true,
        );
        _ideas[ideaIndex] = updatedIdea;
        await _repository.updateIdea(updatedIdea);
        notifyListeners();
      }
    }
  }

  void setSortOption(SortOption option) {
    if (_sortOption != option) {
      _sortOption = option;
      notifyListeners();
    }
  }

  // --- Private Helpers ---
  void _sortIdeas() {
    if (_sortOption == SortOption.rating) {
      _ideas.sort((a, b) => b.rating.compareTo(a.rating));
    } else {
      _ideas.sort((a, b) => b.votes.compareTo(a.votes));
    }
  }

  int _generateAIRating() {
    return 70 + Random().nextInt(31); // Skew ratings to be higher
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
