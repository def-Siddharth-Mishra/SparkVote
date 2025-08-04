import '../../domain/models/idea_model.dart';
import '../../domain/repositories/idea_repository.dart';
import '../datasources/local_storage_service.dart';

class IdeaRepositoryImpl implements IdeaRepository {
  final LocalStorageService _localStorageService;

  IdeaRepositoryImpl(this._localStorageService);

  @override
  Future<List<Idea>> getIdeas() async {
    return await _localStorageService.getIdeas();
  }

  @override
  Future<void> saveIdea(Idea idea) async {
    final ideas = await getIdeas();
    ideas.add(idea);
    await _localStorageService.saveIdeas(ideas);
  }

  @override
  Future<void> updateIdea(Idea idea) async {
    final ideas = await getIdeas();
    final index = ideas.indexWhere((i) => i.id == idea.id);
    if (index != -1) {
      ideas[index] = idea;
      await _localStorageService.saveIdeas(ideas);
    }
  }
}
