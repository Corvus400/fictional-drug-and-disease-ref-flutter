import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'DiseaseDto with nested epidemiology roundtrips correctly [assertion 1/4]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseDto.fromJson(json);

      expect(dto.id, 'disease_0079');
      Object.hashAll([dto.epidemiology, isNotNull]);

      Object.hashAll([dto.severityGrading, isNotNull]);

      Object.hashAll([dto.toJson(), json]);
    },
  );

  test(
    'DiseaseDto with nested epidemiology roundtrips correctly [assertion 2/4]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseDto.fromJson(json);

      Object.hashAll([dto.id, 'disease_0079']);

      expect(dto.epidemiology, isNotNull);
      Object.hashAll([dto.severityGrading, isNotNull]);

      Object.hashAll([dto.toJson(), json]);
    },
  );

  test(
    'DiseaseDto with nested epidemiology roundtrips correctly [assertion 3/4]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseDto.fromJson(json);

      Object.hashAll([dto.id, 'disease_0079']);

      Object.hashAll([dto.epidemiology, isNotNull]);

      expect(dto.severityGrading, isNotNull);
      Object.hashAll([dto.toJson(), json]);
    },
  );

  test(
    'DiseaseDto with nested epidemiology roundtrips correctly [assertion 4/4]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseDto.fromJson(json);

      Object.hashAll([dto.id, 'disease_0079']);

      Object.hashAll([dto.epidemiology, isNotNull]);

      Object.hashAll([dto.severityGrading, isNotNull]);

      expect(dto.toJson(), json);
    },
  );

  test(
    'DiseaseDto parses nested detail objects as typed DTOs [assertion 1/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseDto.fromJson(json);

      expect(dto.epidemiology, isA<EpidemiologyInfoDto>());
      Object.hashAll([dto.symptoms, isA<SymptomInfoDto>()]);

      Object.hashAll([
        dto.diagnosticCriteria,
        isA<DiagnosticCriteriaInfoDto>(),
      ]);

      Object.hashAll([dto.requiredExams, everyElement(isA<ExamDto>())]);

      Object.hashAll([dto.severityGrading, isA<SeverityInfoDto>()]);

      Object.hashAll([dto.treatments, isA<TreatmentInfoDto>()]);
    },
  );

  test(
    'DiseaseDto parses nested detail objects as typed DTOs [assertion 2/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseDto.fromJson(json);

      Object.hashAll([dto.epidemiology, isA<EpidemiologyInfoDto>()]);

      expect(dto.symptoms, isA<SymptomInfoDto>());
      Object.hashAll([
        dto.diagnosticCriteria,
        isA<DiagnosticCriteriaInfoDto>(),
      ]);

      Object.hashAll([dto.requiredExams, everyElement(isA<ExamDto>())]);

      Object.hashAll([dto.severityGrading, isA<SeverityInfoDto>()]);

      Object.hashAll([dto.treatments, isA<TreatmentInfoDto>()]);
    },
  );

  test(
    'DiseaseDto parses nested detail objects as typed DTOs [assertion 3/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseDto.fromJson(json);

      Object.hashAll([dto.epidemiology, isA<EpidemiologyInfoDto>()]);

      Object.hashAll([dto.symptoms, isA<SymptomInfoDto>()]);

      expect(dto.diagnosticCriteria, isA<DiagnosticCriteriaInfoDto>());
      Object.hashAll([dto.requiredExams, everyElement(isA<ExamDto>())]);

      Object.hashAll([dto.severityGrading, isA<SeverityInfoDto>()]);

      Object.hashAll([dto.treatments, isA<TreatmentInfoDto>()]);
    },
  );

  test(
    'DiseaseDto parses nested detail objects as typed DTOs [assertion 4/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseDto.fromJson(json);

      Object.hashAll([dto.epidemiology, isA<EpidemiologyInfoDto>()]);

      Object.hashAll([dto.symptoms, isA<SymptomInfoDto>()]);

      Object.hashAll([
        dto.diagnosticCriteria,
        isA<DiagnosticCriteriaInfoDto>(),
      ]);

      expect(dto.requiredExams, everyElement(isA<ExamDto>()));
      Object.hashAll([dto.severityGrading, isA<SeverityInfoDto>()]);

      Object.hashAll([dto.treatments, isA<TreatmentInfoDto>()]);
    },
  );

  test(
    'DiseaseDto parses nested detail objects as typed DTOs [assertion 5/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseDto.fromJson(json);

      Object.hashAll([dto.epidemiology, isA<EpidemiologyInfoDto>()]);

      Object.hashAll([dto.symptoms, isA<SymptomInfoDto>()]);

      Object.hashAll([
        dto.diagnosticCriteria,
        isA<DiagnosticCriteriaInfoDto>(),
      ]);

      Object.hashAll([dto.requiredExams, everyElement(isA<ExamDto>())]);

      expect(dto.severityGrading, isA<SeverityInfoDto>());
      Object.hashAll([dto.treatments, isA<TreatmentInfoDto>()]);
    },
  );

  test(
    'DiseaseDto parses nested detail objects as typed DTOs [assertion 6/6]',
    () {
      final fixture = File(
        'test/fixtures/swagger/get_v1_diseases__id_.json',
      ).readAsStringSync();
      final json = jsonDecode(fixture) as Map<String, dynamic>;

      final dto = DiseaseDto.fromJson(json);

      Object.hashAll([dto.epidemiology, isA<EpidemiologyInfoDto>()]);

      Object.hashAll([dto.symptoms, isA<SymptomInfoDto>()]);

      Object.hashAll([
        dto.diagnosticCriteria,
        isA<DiagnosticCriteriaInfoDto>(),
      ]);

      Object.hashAll([dto.requiredExams, everyElement(isA<ExamDto>())]);

      Object.hashAll([dto.severityGrading, isA<SeverityInfoDto>()]);

      expect(dto.treatments, isA<TreatmentInfoDto>());
    },
  );
}
