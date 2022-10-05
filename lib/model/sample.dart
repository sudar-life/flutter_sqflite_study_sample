class SampleFields {
  static final String id = '_id';
  static final String name = 'name';
  static final String yn = 'yn';
  static final String value = 'value';
  static final String createdAt = 'createdAt';
}

class Sample {
  static String tableName = 'sample';

  final int? id;
  final String name;
  final bool yn;
  final double value;
  final DateTime createdAt;

  const Sample({
    this.id,
    required this.name,
    required this.yn,
    required this.value,
    required this.createdAt,
  });

  Map<String, dynamic?> toJson() {
    return {
      SampleFields.id: id,
      SampleFields.name: name,
      SampleFields.yn: yn ? 1 : 0,
      SampleFields.value: value,
      SampleFields.createdAt: createdAt
          .toIso8601String(), //DateTime is not a supported SQLite type. Personally I store them as int (millisSinceEpoch) or string (iso8601)
    };
  }

  factory Sample.fromJson(Map<String, dynamic> json) {
    return Sample(
      id: json[SampleFields.id] as int?,
      name: json[SampleFields.name] == null
          ? ''
          : json[SampleFields.name] as String,
      yn: json[SampleFields.yn] == null ? true : json[SampleFields.yn] == 1,
      value: json[SampleFields.value] == null
          ? 0
          : json[SampleFields.value] as double,
      createdAt: json[SampleFields.createdAt] == null
          ? DateTime.now()
          : DateTime.parse(json[SampleFields.createdAt] as String),
    );
  }

  Sample clone({
    int? id,
    String? name,
    bool? yn,
    double? value,
    DateTime? createdAt,
  }) {
    return Sample(
      id: id ?? this.id,
      name: name ?? this.name,
      yn: yn ?? this.yn,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
