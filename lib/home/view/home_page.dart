import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_reader_hive2/home/scans_cubit/scans_cubit.dart';
import 'package:qr_reader_hive2/home/tab_cubit/tab_cubit.dart';
import 'package:qr_reader_hive2/home/view/view.dart';
import 'package:qr_reader_hive2/home/widgets/widgets.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  static const name = 'home';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TabCubit(),
        ),
        BlocProvider(
          create: (_) => ScansCubit(
            dataPersistence: context.read<DataPersistence>(),
          ),
        ),
      ],
      child: const ViewHome(),
    );
  }
}

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey.shade200,
      ),
    );
    final cubit = context.read<ScansCubit>();
    if (cubit.state.isInitial) {
      cubit.getScans();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScansCubit, ScansState>(
      builder: (context, scansState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Historial'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: () => context.read<ScansCubit>().deleteAllScans(),
              ),
            ],
          ),
          bottomNavigationBar: const CustomNavigatorBar(),
          floatingActionButton: const ScanButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: BlocBuilder<TabCubit, TabState>(
            builder: (context, tabState) {
              if (scansState.isLoading || scansState.isInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (scansState is ScansSuccessful) {
                switch (tabState.index) {
                  case 1:
                    return QRPage.directions(scansState.scans.httpScans);

                  default:
                    return QRPage.maps(scansState.scans.geoScans);
                }
              }

              return const Center(
                child: Text('Error Gil'),
              );
            },
          ),
        );
      },
    );
  }
}
