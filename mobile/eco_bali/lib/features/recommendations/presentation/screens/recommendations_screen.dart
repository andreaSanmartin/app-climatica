import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/components/category_badge.dart';
import '../../../../shared/widgets/async_value_widget.dart';
import '../../data/models/recommendation_model.dart';
import '../providers/recommendations_providers.dart';

class RecommendationsScreen extends ConsumerWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationsAsync = ref.watch(recommendationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Recomendaciones')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(recommendationsProvider.future),
        child: AsyncValueWidget<RecommendationsResult>(
          value: recommendationsAsync,
          onRetry: () => ref.invalidate(recommendationsProvider),
          data: (result) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Para las condiciones actuales',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              ...result.recommendations.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _RecommendationCard(item: item),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final RecommendationModel item;

  const _RecommendationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CategoryBadge(category: item.category),
            const SizedBox(width: 14),
            Expanded(child: Text(item.message, style: Theme.of(context).textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }
}
