import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:qr_reader_hive2/app/view/app.dart';

void main() async {
  const dataPersistence = DataPersistence();
  await dataPersistence.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const App(
      dataPersistence: dataPersistence,
    ),
  );
}
