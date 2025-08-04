import '../models/idea_model.dart';

abstract class IdeaRepository {
  Future<List<Idea>> getIdeas();
  Future<void> saveIdea(Idea idea);
  Future<void> updateIdea(Idea idea);
}
