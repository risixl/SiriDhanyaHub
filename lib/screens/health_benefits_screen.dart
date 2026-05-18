import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class HealthBenefitsScreen extends StatefulWidget {
  const HealthBenefitsScreen({super.key});

  @override
  State<HealthBenefitsScreen> createState() => _HealthBenefitsScreenState();
}

class _HealthBenefitsScreenState extends State<HealthBenefitsScreen> {
  HealthFact? _expandedFact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Benefits'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showDisclaimer(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.withValues(alpha: 0.15),
                    Colors.green.withValues(alpha: 0.1)
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.teal.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Text('💊', style: TextStyle(fontSize: 36)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Backed by simple facts — why millets are nature\'s superfoods.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Fact cards
            ...HealthData.facts.map((fact) => _HealthCard(
                  fact: fact,
                  isExpanded: _expandedFact == fact,
                  onTap: () => setState(() {
                    _expandedFact = _expandedFact == fact ? null : fact;
                  }),
                )),

            const SizedBox(height: 8),

            // GI Table
            _GITable(),
          ],
        ),
      ),
    );
  }

  void _showDisclaimer(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Disclaimer'),
        content: const Text(
          'This information is for general awareness only. '
          'Consult a qualified healthcare professional for medical advice. '
          'These facts are based on publicly available nutritional research.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Understood'),
          )
        ],
      ),
    );
  }
}

class _HealthCard extends StatelessWidget {
  final HealthFact fact;
  final bool isExpanded;
  final VoidCallback onTap;

  const _HealthCard({
    required this.fact,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isExpanded
                ? AppTheme.primary.withValues(alpha: 0.4)
                : AppTheme.divider,
            width: isExpanded ? 1.5 : 1,
          ),
          boxShadow: isExpanded
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(fact.emoji, style: const TextStyle(fontSize: 36)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fact.millet.kannadaName,
                          style: const TextStyle(
                            color: AppTheme.secondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          fact.headline,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppTheme.textLight,
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: 12),
                const Divider(color: AppTheme.divider),
                const SizedBox(height: 12),
                Text(
                  fact.body,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Text('Key Nutrients',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: fact.nutrients
                      .map((n) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.teal.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.teal.withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              n,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.teal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Text('Health Benefits',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...fact.benefits.map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: AppTheme.upColor, size: 18),
                          const SizedBox(width: 8),
                          Text(b, style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _GITable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rows = [
      ('Navane (Foxtail)', '31 — Very Low'),
      ('Saame (Little)', '52 — Low'),
      ('Oodalu (Barnyard)', '50 — Low'),
      ('Baragu (Sorghum)', '55 — Low'),
      ('Ragi (Finger)', '65 — Medium'),
      ('White Rice', '72 — High'),
      ('White Bread', '75 — High'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Glycemic Index Comparison',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text('Lower GI = better blood sugar control',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppTheme.textLight)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.divider),
          ),
          child: Column(
            children: rows.asMap().entries.map((e) {
              final isLast = e.key == rows.length - 1;
              final isHighGI = e.value.$2.contains('High');
              final color = isHighGI
                  ? AppTheme.downColor
                  : (e.value.$2.contains('Very Low')
                      ? AppTheme.upColor
                      : AppTheme.secondary);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            e.value.$1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: isHighGI
                                        ? FontWeight.w400
                                        : FontWeight.w600),
                          ),
                        ),
                        Text(
                          e.value.$2,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    const Divider(
                        height: 1, color: AppTheme.divider, indent: 16),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
