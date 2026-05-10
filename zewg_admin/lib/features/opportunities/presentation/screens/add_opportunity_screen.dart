import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../widgets/opportunity_form.dart';

class AddOpportunityScreen extends StatelessWidget {
  const AddOpportunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZewgTheme.background,
      appBar: AppBar(
        backgroundColor: ZewgTheme.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ZewgTheme.textPrimary,
            size: 20,
          ),
        ),
        title: const Text(
          'Add Opportunity',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: ZewgTheme.textPrimary,
          ),
        ),
      ),
      bottomNavigationBar: ZewgBottomNav(
        currentIndex: 1,
        onTap: (i) {
          if (i == 0) {
            context.pop();
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: OpportunityForm(
          onSubmit: (opp) {
            context.pop(opp);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Opportunity published!'),
                backgroundColor: ZewgTheme.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}
