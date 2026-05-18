import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class PriceDetailScreen extends StatelessWidget {
  final MilletPrice price;

  const PriceDetailScreen({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final isUp = price.isUp;
    final trendColor = isUp ? AppTheme.upColor : AppTheme.downColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('${price.millet.kannadaName} — ${price.city}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero price card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primary.withValues(alpha: 0.1),
                    AppTheme.accent.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.divider),
              ),
              child: Row(
                children: [
                  Text(price.millet.emoji,
                      style: const TextStyle(fontSize: 56)),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(price.millet.englishName,
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(
                        '₹${price.currentPrice.toStringAsFixed(2)} /kg',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: AppTheme.primaryDark),
                      ),
                      Row(
                        children: [
                          Icon(
                            isUp ? Icons.arrow_upward : Icons.arrow_downward,
                            color: trendColor,
                            size: 16,
                          ),
                          Text(
                            '₹${price.change.abs().toStringAsFixed(2)} (${price.changePercent.abs().toStringAsFixed(2)}%)',
                            style: TextStyle(
                              color: trendColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 7-day chart
            Text('7-Day Price Chart',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Container(
              height: 200,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.divider),
              ),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (_) => const FlLine(
                      color: AppTheme.divider,
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (v, _) => Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            days[v.toInt() % days.length],
                            style: const TextStyle(
                                fontSize: 10, color: AppTheme.textLight),
                          ),
                        ),
                        reservedSize: 22,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (v, _) => Text(
                          '₹${v.toInt()}',
                          style: const TextStyle(
                              fontSize: 10, color: AppTheme.textLight),
                        ),
                        reservedSize: 36,
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: price.last7Days
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value))
                          .toList(),
                      isCurved: true,
                      color: trendColor,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: trendColor.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Stats row
            Row(
              children: [
                Expanded(
                    child: _StatCard(
                        label: '7D High',
                        value: '₹${price.high7.toStringAsFixed(1)}',
                        color: AppTheme.upColor)),
                const SizedBox(width: 10),
                Expanded(
                    child: _StatCard(
                        label: '7D Low',
                        value: '₹${price.low7.toStringAsFixed(1)}',
                        color: AppTheme.downColor)),
                const SizedBox(width: 10),
                Expanded(
                    child: _StatCard(
                        label: 'Change',
                        value: '${price.changePercent.toStringAsFixed(1)}%',
                        color: trendColor)),
              ],
            ),

            const SizedBox(height: 24),

            // Daily prices list
            Text('Daily Prices', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...price.last7Days.asMap().entries.map((e) {
              final isToday = e.key == price.last7Days.length - 1;
              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isToday
                      ? AppTheme.primary.withValues(alpha: 0.08)
                      : AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: isToday
                          ? AppTheme.primary.withValues(alpha: 0.3)
                          : AppTheme.divider),
                ),
                child: Row(
                  children: [
                    Text(
                      days[e.key % days.length],
                      style: TextStyle(
                        fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                        color: isToday
                            ? AppTheme.primaryDark
                            : AppTheme.textMedium,
                      ),
                    ),
                    if (isToday)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Today',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700)),
                      ),
                    const Spacer(),
                    Text(
                      '₹${e.value.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color:
                            isToday ? AppTheme.primaryDark : AppTheme.textDark,
                        fontSize: isToday ? 16 : 14,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(fontSize: 12, color: AppTheme.textLight)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }
}
