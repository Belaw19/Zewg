import 'package:flutter_test/flutter_test.dart';
import 'package:zewg_admin/features/opportunities/data/mappers/opportunity_mapper.dart';
import 'package:zewg_admin/features/opportunities/domain/opportunity.dart';

import 'helpers/sample_data.dart';

void main() {
  group('ApplicationStep', () {
    test('copyWith updates title and description', () {
      final step = ApplicationStep(title: 'Review', description: 'Initial screen');
      final updated = step.copyWith(description: 'Panel review');

      expect(updated.title, 'Review');
      expect(updated.description, 'Panel review');
    });
  });

  group('Opportunity', () {
    test('holds core fields', () {
      expect(sampleInternship.id, 'opp-1');
      expect(sampleInternship.title, 'Flutter Developer Intern');
      expect(sampleInternship.category, 'Internship');
      expect(sampleInternship.company, 'Acme Corp');
      expect(sampleInternship.skills, contains('Flutter'));
    });

    test('testOpportunities includes three categories', () {
      final categories = testOpportunities.map((o) => o.category).toSet();
      expect(categories, containsAll(['Internship', 'Job', 'Scholarship']));
    });
  });

  group('OpportunityMapper', () {
    test('fromApi maps API category to display label', () {
      final opp = OpportunityMapper.fromApi({
        'id': 'api-1',
        'title': 'Product Designer',
        'company': 'Design Co',
        'category': 'JOB',
        'location': 'Hybrid',
        'workType': 'Hybrid',
        'createdAt': '2026-01-15T00:00:00.000Z',
      });

      expect(opp.category, 'Job');
      expect(opp.workType, 'Hybrid');
      expect(opp.company, 'Design Co');
    });

    test('toApi maps display category back to API format', () {
      final body = OpportunityMapper.toApi(sampleJob);

      expect(body['category'], 'JOB');
      expect(body['title'], sampleJob.title);
      expect(body['type'], 'job');
    });
  });
}
