// import 'package:data_persistence/data_persistence.dart';
// import 'package:flutter/material.dart';

// class ScanListProvider extends ChangeNotifier {
//   List<ScanModel>? scans = [];
//   String typeSelected = 'http';

//   Future<void> newScan(String value) async {
//     final newScan = ScanModel(value: value);

//     final id = await const DataPersistence().addScan(newScan);
//     // Assign the id of the data base to the model.
//     newScan.id = id;

//     if (typeSelected == newScan.type) {
//       scans?.add(newScan);
//       notifyListeners();
//     }
//   }

//   Future<void> loadScans() async {
//     final scans = const DataPersistence().scans;
//     this.scans = [...?scans];
//     notifyListeners();
//   }

//   Future<void> loadScanByType(String type) async {
//     final scans = const DataPersistence().getScanByType(type);
//     this.scans = [...?scans];
//     typeSelected = type;
//     notifyListeners();
//   }

//   Future<void> deleteScanById(int id) async {
//     await const DataPersistence().deleteScanById(id);
//     await loadScanByType(typeSelected);
//   }

//   Future<void> deleteScans() async {
//     await const DataPersistence().deleteAllScans();
//     scans = [];
//     notifyListeners();
//   }
// }
