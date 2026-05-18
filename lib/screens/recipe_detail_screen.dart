import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../providers/app_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isSaved = provider.isRecipeSaved(recipe.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_outline,
                  color: Colors.white,
                ),
                onPressed: () => provider.toggleSaveRecipe(recipe.id),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe.title),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primaryDark, AppTheme.primary],
                  ),
                ),
                child: Center(
                  child: Text(
                    recipe.imageEmoji,
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kannada title
                  Text(
                    recipe.titleKannada,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textLight,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Meta info row
                  Row(
                    children: [
                      _MetaBadge(
                          icon: Icons.access_time,
                          label: '${recipe.cookTimeMinutes} min'),
                      const SizedBox(width: 8),
                      _MetaBadge(
                          icon: Icons.people_outline,
                          label: '${recipe.servings} servings'),
                      const SizedBox(width: 8),
                      _MetaBadge(
                          icon: Icons.bar_chart, label: recipe.difficulty),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Text(recipe.description,
                      style: Theme.of(context).textTheme.bodyLarge),

                  const SizedBox(height: 12),

                  // Health tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: recipe.healthTags
                        .map((tag) => Chip(label: Text(tag)))
                        .toList(),
                  ),

                  const SizedBox(height: 24),

                  // Ingredients
                  const _SectionTitle(title: '🛒 Ingredients'),
                  const SizedBox(height: 12),
                  ...recipe.ingredients.map((ing) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(top: 6, right: 10),
                              decoration: const BoxDecoration(
                                color: AppTheme.secondary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ing,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      )),

                  const SizedBox(height: 24),

                  // Steps
                  const _SectionTitle(title: '👩‍🍳 Steps'),
                  const SizedBox(height: 12),
                  ...recipe.steps.asMap().entries.map((e) => _StepTile(
                        number: e.key + 1,
                        step: e.value,
                        isLast: e.key == recipe.steps.length - 1,
                      )),

                  const SizedBox(height: 24),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => provider.toggleSaveRecipe(recipe.id),
                      icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_outline),
                      label: Text(
                          isSaved ? 'Saved to Favourites ✓' : 'Save Recipe'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSaved ? AppTheme.secondary : AppTheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      );
}

class _MetaBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.primary),
          const SizedBox(width: 5),
          Text(label,
              style: const TextStyle(
                  color: AppTheme.primaryDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final int number;
  final String step;
  final bool isLast;

  const _StepTile(
      {required this.number, required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppTheme.primary.withValues(alpha: 0.2),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
