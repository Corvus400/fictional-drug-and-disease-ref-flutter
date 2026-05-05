import 'dart:convert';

import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';

/// Encodes and decodes persisted search query JSON.
final class SearchQueryCodec {
  /// Creates a codec.
  const SearchQueryCodec();

  /// Encodes drug or disease search params as stable JSON text.
  String encode(Object params) {
    final map = switch (params) {
      DrugSearchParams() => _encodeDrug(params),
      DiseaseSearchParams() => _encodeDisease(params),
      _ => throw ArgumentError.value(params, 'params', 'Unsupported params'),
    };
    final entries = map.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return jsonEncode(Map<String, Object?>.fromEntries(entries));
  }

  /// Decodes drug search params.
  DrugSearchParams decodeDrug(String jsonText) {
    final json = _decode(jsonText);
    return DrugSearchParams(
      page: _int(json['page']),
      pageSize: _int(json['page_size']),
      categoryAtc: _string(json['category_atc']),
      therapeuticCategory: _string(json['therapeutic_category']),
      regulatoryClass: _stringList(json['regulatory_class']),
      dosageForm: _stringList(json['dosage_form']),
      route: _stringList(json['route']),
      keyword: _string(json['keyword']),
      keywordMatch: _bySerialName(
        KeywordMatch.values,
        _string(json['keyword_match']),
      ),
      keywordTarget: _bySerialName(
        DrugKeywordTarget.values,
        _string(json['keyword_target']),
      ),
      adverseReactionKeyword: _string(json['adverse_reaction_keyword']),
      precautionCategory: _stringList(json['precaution_category']),
      sort: _bySerialName(DrugSort.values, _string(json['sort'])),
    );
  }

  /// Decodes disease search params.
  DiseaseSearchParams decodeDisease(String jsonText) {
    final json = _decode(jsonText);
    return DiseaseSearchParams(
      page: _int(json['page']),
      pageSize: _int(json['page_size']),
      icd10Chapter: _stringList(json['icd10_chapter']),
      department: _stringList(json['department']),
      chronicity: _stringList(json['chronicity']),
      infectious: _bool(json['infectious']),
      keyword: _string(json['keyword']),
      keywordMatch: _bySerialName(
        KeywordMatch.values,
        _string(json['keyword_match']),
      ),
      keywordTarget: _bySerialName(
        DiseaseKeywordTarget.values,
        _string(json['keyword_target']),
      ),
      symptomKeyword: _string(json['symptom_keyword']),
      onsetPattern: _stringList(json['onset_pattern']),
      examCategory: _stringList(json['exam_category']),
      hasPharmacologicalTreatment: _bool(
        json['has_pharmacological_treatment'],
      ),
      hasSeverityGrading: _bool(json['has_severity_grading']),
      sort: _bySerialName(DiseaseSort.values, _string(json['sort'])),
    );
  }

  /// Counts active filter fields, excluding keyword, sort, page and page size.
  int filterCountFor(Object params) {
    final map = switch (params) {
      DrugSearchParams() => _encodeDrug(params),
      DiseaseSearchParams() => _encodeDisease(params),
      _ => throw ArgumentError.value(params, 'params', 'Unsupported params'),
    };
    const ignored = {'keyword', 'sort', 'page', 'page_size'};
    return map.entries
        .where((entry) => !ignored.contains(entry.key))
        .where((entry) => _hasValue(entry.value))
        .length;
  }

  Map<String, Object?> _encodeDrug(DrugSearchParams params) => {
    'page': params.page,
    'page_size': params.pageSize,
    'category_atc': params.categoryAtc,
    'therapeutic_category': params.therapeuticCategory,
    'regulatory_class': params.regulatoryClass,
    'dosage_form': params.dosageForm,
    'route': params.route,
    'keyword': params.keyword,
    'keyword_match': params.keywordMatch?.serialName,
    'keyword_target': params.keywordTarget?.serialName,
    'adverse_reaction_keyword': params.adverseReactionKeyword,
    'precaution_category': params.precautionCategory,
    'sort': params.sort?.serialName,
  }..removeWhere((_, value) => !_hasValue(value));

  Map<String, Object?> _encodeDisease(DiseaseSearchParams params) => {
    'page': params.page,
    'page_size': params.pageSize,
    'icd10_chapter': params.icd10Chapter,
    'department': params.department,
    'chronicity': params.chronicity,
    'infectious': params.infectious,
    'keyword': params.keyword,
    'keyword_match': params.keywordMatch?.serialName,
    'keyword_target': params.keywordTarget?.serialName,
    'symptom_keyword': params.symptomKeyword,
    'onset_pattern': params.onsetPattern,
    'exam_category': params.examCategory,
    'has_pharmacological_treatment': params.hasPharmacologicalTreatment,
    'has_severity_grading': params.hasSeverityGrading,
    'sort': params.sort?.serialName,
  }..removeWhere((_, value) => !_hasValue(value));
}

Map<String, Object?> _decode(String jsonText) {
  final decoded = jsonDecode(jsonText);
  if (decoded is! Map) {
    throw const FormatException('Search query JSON must be an object');
  }
  return decoded.cast<String, Object?>();
}

T? _bySerialName<T extends Enum>(List<T> values, String? serialName) {
  if (serialName == null) {
    return null;
  }
  for (final value in values) {
    final valueSerialName = switch (value) {
      KeywordMatch() => value.serialName,
      DrugKeywordTarget() => value.serialName,
      DrugSort() => value.serialName,
      DiseaseKeywordTarget() => value.serialName,
      DiseaseSort() => value.serialName,
      _ => value.name,
    };
    if (valueSerialName == serialName) {
      return value;
    }
  }
  throw FormatException('Unknown enum serialName: $serialName');
}

String? _string(Object? value) => value == null ? null : value as String;

int? _int(Object? value) => value == null ? null : value as int;

bool? _bool(Object? value) => value == null ? null : value as bool;

List<String>? _stringList(Object? value) {
  if (value == null) {
    return null;
  }
  return (value as List).cast<String>();
}

bool _hasValue(Object? value) {
  return switch (value) {
    null => false,
    String() => value.isNotEmpty,
    List() => value.isNotEmpty,
    _ => true,
  };
}
