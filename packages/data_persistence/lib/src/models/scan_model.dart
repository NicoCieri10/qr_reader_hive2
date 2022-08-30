import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  /// Retrieves the [LatLng] of the [ScanModel].
  LatLng getLatLng() {
    /// We create a substring starting from the 4th character of the value,
    /// ignoring the 'geo:' prefix, and then we split the string into two parts,
    /// using the ',' character as a separator.
    final latLng = value.substring(4).split(',');

    /// Then we parse the 2 values from string to double.
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);

    /// Finally we return the [LatLng] object.
    return LatLng(lat, lng);
  }
}

/// This [enum] is used to represent the two types of [ScanModel] there is.
enum ScanModelType {
  /// The value contains http in the text
  http,

  /// It does not contains http in the text and therefore is a geo [ScanModel]
  geo,
}

/// Extension on [List] to make it easier to get each type of [ScanModel].
extension ScanList on List<ScanModel>? {
  /// Get geo [ScanModel]s from the [List].
  List<ScanModel>? get geoScans {
    return this?.where((element) => element.type == ScanModelType.geo).toList();
  }

  /// Get http [ScanModel]s from the [List].
  List<ScanModel>? get httpScans {
    return this
        ?.where((element) => element.type == ScanModelType.http)
        .toList();
  }
}
