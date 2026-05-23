import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/opportunity_provider.dart';
import '../widgets/opportunity_form.dart';

class AddOpportunityScreen extends ConsumerWidget {
  const AddOpportunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ZewgTheme.background,
      appBar: AppBar(
        backgroundColor: ZewgTheme.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: ZewgTheme.textPrimary, size: 20),
        ),
        title: const Text(
          'Add Opportunity',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: ZewgTheme.textPrimary),
        ),
      ),
      bottomNavigationBar: ZewgBottomNav(
        currentIndex: 1,
        onTap: (i) {
          if (i == 0) context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: OpportunityForm(
          onSubmit: (opp) async {
            final created = await ref.read(adminOpportunitiesProvider.notifier).create(opp);
            if (!context.mounted) return;
            if (created != null) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opportunity published!'), backgroundColor: ZewgTheme.primary),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to publish'), backgroundColor: ZewgTheme.danger),
              );
            }
          },
        ),
      ),
    );
  }
}
