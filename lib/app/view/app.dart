import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_hive2/home/view/view.dart';
import 'package:qr_reader_hive2/map/view/map_page.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.dataPersistence,
  });

  final DataPersistence dataPersistence;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = router();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => UiProvider()),
        RepositoryProvider.value(value: widget.dataPersistence),
      ],
      child: MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
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

  GoRouter router() {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          name: PageHome.name,
          builder: (context, state) => const PageHome(),
        ),
        GoRoute(
          path: '/',
          name: PageMap.name,
          builder: (context, state) {
            final scan = (state.extra as Map?)?['scan'] as ScanModel?;
            if (scan == null) {
              throw ArgumentError.notNull('scan');
            }
            return PageMap(scan);
          },
        ),
      ],
    );
  }
}
