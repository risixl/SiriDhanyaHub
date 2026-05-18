import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class DirectBuyScreen extends StatefulWidget {
  const DirectBuyScreen({super.key});

  @override
  State<DirectBuyScreen> createState() => _DirectBuyScreenState();
}

class _DirectBuyScreenState extends State<DirectBuyScreen> {
  MilletType? _selectedFilter;

  List<FpoOrg> get _filtered {
    if (_selectedFilter == null) return FpoData.orgs;
    return FpoData.orgs
        .where((o) => o.availableMillets.contains(_selectedFilter))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Direct Buy'),
            Text(
              'Connect with local FPOs',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Info banner
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border:
                  Border.all(color: AppTheme.secondary.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Text('🏪', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Buy directly from Farmer Producer Organisations — cut the middleman, support local farmers.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),

          // Filter chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _FpoFilterChip(
                  label: 'All FPOs',
                  isSelected: _selectedFilter == null,
                  onTap: () => setState(() => _selectedFilter = null),
                ),
                ...MilletType.values.map((m) => _FpoFilterChip(
                      label: '${m.emoji} ${m.kannadaName}',
                      isSelected: _selectedFilter == m,
                      onTap: () => setState(() => _selectedFilter = m),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // FPO list
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🏚️', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text(
                          'No FPOs for this millet yet',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: _filtered.length,
                    itemBuilder: (ctx, i) => _FpoCard(org: _filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _FpoFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FpoFilterChip({
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
          color: isSelected ? AppTheme.secondary : AppTheme.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.secondary : AppTheme.divider,
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

class _FpoCard extends StatefulWidget {
  final FpoOrg org;
  const _FpoCard({required this.org});

  @override
  State<_FpoCard> createState() => _FpoCardState();
}

class _FpoCardState extends State<_FpoCard> {
  bool _requested = false;

  @override
  Widget build(BuildContext context) {
    final org = widget.org;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text('🏘️', style: TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(org.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 13, color: AppTheme.textLight),
                          const SizedBox(width: 3),
                          Text(org.district,
                              style: const TextStyle(
                                  fontSize: 12, color: AppTheme.textLight)),
                          const Spacer(),
                          const Icon(Icons.star,
                              size: 13, color: AppTheme.secondary),
                          const SizedBox(width: 3),
                          Text(
                            org.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Description
            Text(org.description,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 10),

            // Members & millets
            Row(
              children: [
                const Icon(Icons.people, size: 14, color: AppTheme.textLight),
                const SizedBox(width: 4),
                Text('${org.membersCount} farmers',
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textLight)),
                const SizedBox(width: 12),
                Expanded(
                  child: Wrap(
                    spacing: 4,
                    children: org.availableMillets
                        .map((m) => Text(
                              m.emoji,
                              style: const TextStyle(fontSize: 16),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: org.contact));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Phone number copied!'),
                          backgroundColor: AppTheme.primary,
                        ),
                      );
                    },
                    icon: const Icon(Icons.phone_outlined, size: 16),
                    label:
                        Text(org.contact, style: const TextStyle(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primary,
                      side: const BorderSide(color: AppTheme.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _requested
                        ? null
                        : () {
                            setState(() => _requested = true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Request sent to ${org.name}! They will contact you shortly.'),
                                backgroundColor: AppTheme.primary,
                              ),
                            );
                          },
                    icon: Icon(
                        _requested ? Icons.check : Icons.shopping_bag_outlined,
                        size: 16),
                    label: Text(_requested ? 'Requested' : 'Buy Direct'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _requested
                          ? AppTheme.primary.withValues(alpha: 0.5)
                          : AppTheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
