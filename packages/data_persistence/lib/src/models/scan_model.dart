import 'package:hive/hive.dart';

part 'scan_model.g.dart';

@HiveType(typeId: 0)

/// {@template scan_model}
/// This model is used to represent Scan data into the app.
/// {@endtemplate}
class ScanModel {
  /// {@macro scan_model}
  ScanModel({
    required this.id,
    required this.value,
  });

  /// the ID of the [ScanModel].
  @HiveField(0)
  int id;

  /// the value of the [ScanModel].
  /// For e.j. https://google.com
  @HiveField(1)
  String value;

  /// Retrieves the type of the [ScanModel]
  ///
  /// If the value of the [ScanModel] is http... it'll return [ScanModelType.http]
  /// else [ScanModelType.geo].
  ScanModelType get type {
    if (value.contains('http')) {
      return ScanModelType.http;
    }
    return ScanModelType.geo;
  }
}

/// This [enum] is used to represent the two types of [ScanModel] there is.
enum ScanModelType {
  /// The value contains http in the text
  http,

  /// It does not contains http in the text and therefore is a geo [ScanModel]
  geo,
}
