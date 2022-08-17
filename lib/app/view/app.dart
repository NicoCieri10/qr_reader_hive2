import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_hive2/home/home.dart';
import 'package:qr_reader_hive2/maps/maps.dart';
import 'package:qr_reader_hive2/providers/ui_provider.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.dataPersistence,
  });

  final DataPersistence dataPersistence;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => UiProvider()),
        RepositoryProvider.value(value: dataPersistence),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => const PageHome(),
          'maps': (_) => const MapsPage(),
        },
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.deepPurple,
            secondary: Colors.deepPurple,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
