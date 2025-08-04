import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/app_constants.dart';
import '../../domain/models/idea_model.dart';

class LocalStorageService {
  Future<void> saveIdeas(List<Idea> ideas) async {
    final prefs = await SharedPreferences.getInstance();
    final ideasJson = ideas.map((idea) => idea.toJson()).toList();
    await prefs.setStringList(AppConstants.ideasStorageKey, ideasJson);
  }

  Future<List<Idea>> getIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    final ideasJson = prefs.getStringList(AppConstants.ideasStorageKey);
    if (ideasJson == null) {
      return [];
    }
    return ideasJson.map((json) => Idea.fromJson(json)).toList();
  }
}
