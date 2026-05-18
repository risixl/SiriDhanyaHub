import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

class AppProvider extends ChangeNotifier {
  String _selectedCity = 'Bengaluru';
  Set<String> _savedRecipeIds = {};
  MilletType? _selectedMilletFilter;

  String get selectedCity => _selectedCity;
  Set<String> get savedRecipeIds => _savedRecipeIds;
  MilletType? get selectedMilletFilter => _selectedMilletFilter;

  AppProvider() {
    _loadSavedRecipes();
  }

  Future<void> _loadSavedRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('saved_recipes') ?? [];
    _savedRecipeIds = saved.toSet();
    notifyListeners();
  }

  Future<void> toggleSaveRecipe(String recipeId) async {
    if (_savedRecipeIds.contains(recipeId)) {
      _savedRecipeIds.remove(recipeId);
    } else {
      _savedRecipeIds.add(recipeId);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('saved_recipes', _savedRecipeIds.toList());
    notifyListeners();
  }

  bool isRecipeSaved(String recipeId) => _savedRecipeIds.contains(recipeId);

  void setCity(String city) {
    _selectedCity = city;
    notifyListeners();
  }

  void setMilletFilter(MilletType? type) {
    _selectedMilletFilter = type;
    notifyListeners();
  }

  List<Recipe> get filteredRecipes {
    if (_selectedMilletFilter == null) return RecipeData.all;
    return RecipeData.all
        .where((r) => r.milletType == _selectedMilletFilter)
        .toList();
  }

  List<Recipe> get savedRecipes =>
      RecipeData.all.where((r) => _savedRecipeIds.contains(r.id)).toList();
}
