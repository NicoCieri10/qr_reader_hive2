import 'package:data_persistence/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// {@template data_persistence}
/// Repository to handle data persistence.
///
/// To understand more about the package we use to save data, please visit:
/// https://pub.dev/packages/hive.
/// {@endtemplate}
class DataPersistence {
  /// {@macro data_persistence}
  const DataPersistence();

  /// Method to initialize the repository.
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final directory = await getApplicationSupportDirectory();
    if (!directory.existsSync()) {
      directory.createSync();
    }

    Hive
      ..init(directory.path)
      ..registerAdapter(ScanModelAdapter());

    await Future.wait([
      Hive.openBox<dynamic>(DataPersistence._scansBox),
    ]);
  }

  /// Method to get the scans [Box].
  Box<dynamic> get scansBox => Hive.box<dynamic>(DataPersistence._scansBox);

  /// Method to get the scans.
  List<ScanModel>? get scans => (scansBox.get('scans') as List?)
      ?.map((dynamic element) => element as ScanModel)
      .toList();

  /// Method to set the scans.
  Future<void> setScans(List<ScanModel>? list) async =>
      scansBox.put('scans', list);

  /// Method to add a scan.
  Future<int> addScan(String value) async {
    final scanLength = this.scans?.length ?? 0;
    final newScan = ScanModel(
      value: value,
      id: scanLength,
    );

    final scans = this.scans?..add(newScan);
    await scansBox.put('scans', scans);
    return newScan.id;
  }

  /// Method to get all the scans.
  // List<ScanModel>? getAllScans() => scans?.toList();

  /// Method to get a scan by id.
  ScanModel? getScanById(int id) {
    return scans?.firstWhere((element) => element.id == id);
  }

  /// Method to get a scan by tipo.
  List<ScanModel>? getScanByType(ScanModelType type) {
    return scans?.where((element) => element.type == type) as List<ScanModel>?;
  }

  /// Method to update a scan.
  Future<int?> updateScan(ScanModel newScan) async {
    final scans = this.scans?.map((element) {
      if (element.id == newScan.id) element = newScan;
    }).toList();
    await scansBox.put('scans', scans);
    return newScan.id;
  }

  /// Method to delete a scan by id.
  Future<void> deleteScanById(int id) async {
    final scans = this.scans?..removeWhere((element) => element.id == id);
    await scansBox.put('scans', scans);
  }

  /// Method to delete all scans.
  Future<void> deleteAllScans() async {
    await scansBox.delete('scans');
  }

  /// The name of the app scans box.
  static const _scansBox = 'scans';
}
