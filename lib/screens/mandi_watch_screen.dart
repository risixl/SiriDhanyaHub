import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../providers/app_provider.dart';
import '../widgets/widgets.dart';
import 'price_detail_screen.dart';

class MandiWatchScreen extends StatefulWidget {
  const MandiWatchScreen({super.key});

  @override
  State<MandiWatchScreen> createState() => _MandiWatchScreenState();
}

class _MandiWatchScreenState extends State<MandiWatchScreen> {
  bool _isRefreshing = false;

  Future<void> _refresh() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isRefreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final prices = MandiData.getPrices(provider.selectedCity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mandi Watch'),
        actions: [
          IconButton(
            icon: _isRefreshing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2))
                : const Icon(Icons.refresh),
            onPressed: _refresh,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: _CitySelector(
            selectedCity: provider.selectedCity,
            onChanged: provider.setCity,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            _SummaryStrip(prices: prices),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                itemCount: prices.length,
                itemBuilder: (ctx, i) => PriceCard(
                  price: prices[i],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PriceDetailScreen(price: prices[i]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CitySelector extends StatelessWidget {
  final String selectedCity;
  final void Function(String) onChanged;

  const _CitySelector({required this.selectedCity, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: MandiData.cities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final city = MandiData.cities[i];
          final isSelected = city == selectedCity;
          return GestureDetector(
            onTap: () => onChanged(city),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                city,
                style: TextStyle(
                  color: isSelected ? AppTheme.primaryDark : Colors.white,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SummaryStrip extends StatelessWidget {
  final List<MilletPrice> prices;

  const _SummaryStrip({required this.prices});

  @override
  Widget build(BuildContext context) {
    final gainers = prices.where((p) => p.isUp).length;
    final losers = prices.length - gainers;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryItem(
              label: 'Gainers', value: '$gainers', color: AppTheme.upColor),
          _Divider(),
          _SummaryItem(
              label: 'Losers', value: '$losers', color: AppTheme.downColor),
          _Divider(),
          _SummaryItem(
              label: 'Millets',
              value: '${prices.length}',
              color: AppTheme.primary),
          _Divider(),
          const Column(
            children: [
              Text('Updated',
                  style: TextStyle(fontSize: 11, color: AppTheme.textLight)),
              Text(
                'Live',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.upColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryItem(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppTheme.textLight)),
          Text(value,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w800, color: color)),
        ],
      );
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        height: 30,
        color: AppTheme.divider,
      );
}
