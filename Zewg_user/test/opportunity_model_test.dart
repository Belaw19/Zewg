import 'package:flutter_test/flutter_test.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

import 'helpers/sample_data.dart';

void main() {
  group('Opportunity', () {
    test('fromMap parses fields and flags', () {
      final opp = Opportunity.fromMap(sampleOpportunityMap());

      expect(opp.id, 'map-1');
      expect(opp.title, 'Data Analyst');
      expect(opp.company, 'Gamma LLC');
      expect(opp.category, 'JOB');
      expect(opp.tags, ['SQL', 'Python']);
      expect(opp.isSaved, isTrue);
      expect(opp.isApplied, isFalse);
    });

    test('fromApi uses category and defaults', () {
      final opp = Opportunity.fromApi({
        'id': 'api-1',
        'title': 'Product Designer',
        'company': 'Design Co',
        'category': 'INTERNSHIP',
        'location': 'Hybrid',
        'workType': 'Part-time',
      });

      expect(opp.type, 'internship');
      expect(opp.tags, contains('Part-time'));
      expect(opp.tags, contains('Hybrid'));
    });

    test('copyWith updates save and apply flags', () {
      final updated = sampleInternship.copyWith(isSaved: true, isApplied: true);

      expect(updated.id, sampleInternship.id);
      expect(updated.isSaved, isTrue);
      expect(updated.isApplied, isTrue);
      expect(updated.title, sampleInternship.title);
    });

    test('toMap round-trips core fields', () {
      final map = sampleJob.toMap();

      expect(map['id'], sampleJob.id);
      expect(map['title'], sampleJob.title);
      expect(map['category'], 'JOB');
      expect(map['is_saved'], 0);
      expect(map['is_applied'], 0);
    });

    test('fromMap derives category from type when missing', () {
      final opp = Opportunity.fromMap({
        'id': 't-1',
        'title': 'Grant',
        'company': 'Org',
        'type': 'scholarship',
      });

      expect(opp.category, 'SCHOLARSHIP');
      expect(opp.type, 'scholarship');
    });
  });
}
