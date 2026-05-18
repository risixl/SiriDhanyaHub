import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../providers/app_provider.dart';
import '../widgets/widgets.dart';
import 'recipe_detail_screen.dart';

class RecipeLabScreen extends StatefulWidget {
  const RecipeLabScreen({super.key});

  @override
  State<RecipeLabScreen> createState() => _RecipeLabScreenState();
}

class _RecipeLabScreenState extends State<RecipeLabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Recipe> _filterSearch(List<Recipe> recipes) {
    if (_searchQuery.isEmpty) return recipes;
    final q = _searchQuery.toLowerCase();
    return recipes
        .where((r) =>
            r.title.toLowerCase().contains(q) ||
            r.milletType.kannadaName.toLowerCase().contains(q) ||
            r.milletType.englishName.toLowerCase().contains(q) ||
            r.healthTags.any((t) => t.toLowerCase().contains(q)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Lab'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'All Recipes'),
            Tab(text: 'Saved'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All Recipes Tab
          Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by millet type or dish name...',
                    prefixIcon:
                        const Icon(Icons.search, color: AppTheme.textLight),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                  ),
                  onChanged: (v) => setState(() => _searchQuery = v),
                ),
              ),
              // Millet filter chips
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _FilterChip(
                      label: 'All',
                      isSelected: provider.selectedMilletFilter == null,
                      onTap: () => provider.setMilletFilter(null),
                    ),
                    ...MilletType.values.map((m) => _FilterChip(
                          label: '${m.emoji} ${m.kannadaName}',
                          isSelected: provider.selectedMilletFilter == m,
                          onTap: () => provider.setMilletFilter(m),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Recipe list
              Expanded(
                child: Builder(builder: (ctx) {
                  final recipes = _filterSearch(provider.filteredRecipes);
                  if (recipes.isEmpty) {
                    return const EmptyState(
                      emoji: '🔍',
                      title: 'No recipes found',
                      subtitle: 'Try a different millet type or search term.',
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: recipes.length,
                    itemBuilder: (ctx, i) {
                      final recipe = recipes[i];
                      return RecipeCard(
                        recipe: recipe,
                        isSaved: provider.isRecipeSaved(recipe.id),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RecipeDetailScreen(recipe: recipe),
                          ),
                        ),
                        onSave: () => provider.toggleSaveRecipe(recipe.id),
                      );
                    },
                  );
                }),
              ),
            ],
          ),

          // Saved Recipes Tab
          Builder(builder: (ctx) {
            final saved = provider.savedRecipes;
            if (saved.isEmpty) {
              return const EmptyState(
                emoji: '🔖',
                title: 'No saved recipes',
                subtitle:
                    'Tap the bookmark icon on any recipe to save it here.',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: saved.length,
              itemBuilder: (ctx, i) {
                final recipe = saved[i];
                return RecipeCard(
                  recipe: recipe,
                  isSaved: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipeDetailScreen(recipe: recipe),
                    ),
                  ),
                  onSave: () => provider.toggleSaveRecipe(recipe.id),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.divider,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : AppTheme.textMedium,
          ),
        ),
      ),
    );
  }
}
