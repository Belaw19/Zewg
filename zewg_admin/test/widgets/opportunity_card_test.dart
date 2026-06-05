import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zewg_admin/core/widgets/common_widgets.dart';

import '../helpers/sample_data.dart';

void main() {
  testWidgets('OpportunityCard shows title, company, and category badge', (tester) async {
    var editTapped = false;
    var deleteTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OpportunityCard(
            opportunity: sampleInternship,
            onEdit: () => editTapped = true,
            onDelete: () => deleteTapped = true,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Flutter Developer Intern'), findsOneWidget);
    expect(find.text('Acme Corp'), findsOneWidget);
    expect(find.text('INTERNSHIP'), findsOneWidget);
    expect(find.text('Remote'), findsWidgets);

    await tester.tap(find.byIcon(Icons.edit_outlined));
    expect(editTapped, isTrue);

    await tester.tap(find.byIcon(Icons.delete_outline));
    expect(deleteTapped, isTrue);
  });
}
