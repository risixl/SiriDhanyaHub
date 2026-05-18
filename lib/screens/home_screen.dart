import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'mandi_watch_screen.dart';
import 'recipe_lab_screen.dart';
import 'health_benefits_screen.dart';
import 'direct_buy_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.show_chart_outlined),
      selectedIcon: Icon(Icons.show_chart),
      label: 'Mandi',
    ),
    NavigationDestination(
      icon: Icon(Icons.menu_book_outlined),
      selectedIcon: Icon(Icons.menu_book),
      label: 'Recipes',
    ),
    NavigationDestination(
      icon: Icon(Icons.health_and_safety_outlined),
      selectedIcon: Icon(Icons.health_and_safety),
      label: 'Health',
    ),
    NavigationDestination(
      icon: Icon(Icons.store_outlined),
      selectedIcon: Icon(Icons.store),
      label: 'Buy',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screens = [
      _DashboardTab(onNavigate: _selectTab),
      const MandiWatchScreen(),
      const RecipeLabScreen(),
      const HealthBenefitsScreen(),
      const DirectBuyScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _selectTab,
        destinations: _destinations,
        backgroundColor: AppTheme.surface,
        indicatorColor: AppTheme.primary.withValues(alpha: 0.15),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
    );
  }

  void _selectTab(int index) {
    setState(() => _currentIndex = index);
  }
}

// ─── Dashboard Tab ────────────────────────────────────────────────────────────

class _DashboardTab extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const _DashboardTab({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Siri-Dhanya Hub'),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primaryDark, AppTheme.primary],
                  ),
                ),
                child: const Center(
                  child: Text('🌾', style: TextStyle(fontSize: 60)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _WelcomeBanner(),
          ),
          SliverToBoxAdapter(
            child: _QuickActions(onNavigate: onNavigate),
          ),
          SliverToBoxAdapter(
            child: _ImpactSection(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _WelcomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.accent.withValues(alpha: 0.4),
            AppTheme.accent.withValues(alpha: 0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ಸಿರಿ-ಧಾನ್ಯ ಹಬ್ಬಕ್ಕೆ ಸ್ವಾಗತ',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primaryDark,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your Millet Value Chain companion — empowering farmers & consumers of Karnataka.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppTheme.textMedium),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const _QuickActions({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionItem(
          '📈', 'Mandi\nWatch', AppTheme.upColor.withValues(alpha: 0.15), 1),
      _ActionItem(
          '🍳', 'Recipe\nLab', AppTheme.secondary.withValues(alpha: 0.15), 2),
      _ActionItem(
          '💊', 'Health\nGuide', Colors.teal.withValues(alpha: 0.15), 3),
      _ActionItem(
          '🏪', 'Direct\nBuy', AppTheme.primary.withValues(alpha: 0.15), 4),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Access', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Row(
            children: actions
                .map((a) => Expanded(
                      child: _QuickActionTile(
                        item: a,
                        onNavigate: onNavigate,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ActionItem {
  final String emoji;
  final String label;
  final Color bgColor;
  final int navIndex;
  _ActionItem(this.emoji, this.label, this.bgColor, this.navIndex);
}

class _QuickActionTile extends StatelessWidget {
  final _ActionItem item;
  final ValueChanged<int> onNavigate;

  const _QuickActionTile({
    required this.item,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onNavigate(item.navIndex),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: item.bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: item.bgColor, width: 1.5),
        ),
        child: Column(
          children: [
            Text(item.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImpactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Why Millets?', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const _ImpactCard(
            emoji: '💧',
            title: '70% Less Water',
            body:
                'Millets need 70% less water than paddy rice — a lifeline for dry Karnataka districts.',
            color: Colors.blue,
          ),
          const SizedBox(height: 8),
          const _ImpactCard(
            emoji: '🏥',
            title: 'Fight Malnutrition',
            body:
                'Superfoods for anaemia, diabetes, obesity — millets are nature\'s medicine.',
            color: Colors.teal,
          ),
          const SizedBox(height: 8),
          const _ImpactCard(
            emoji: '🌡️',
            title: 'Climate Resilient',
            body:
                'Grow in poor soils with minimal rainfall — essential for climate-smart farming.',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class _ImpactCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String body;
  final Color color;

  const _ImpactCard({
    required this.emoji,
    required this.title,
    required this.body,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: color.withValues(alpha: 0.9),
                        )),
                const SizedBox(height: 3),
                Text(body, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
