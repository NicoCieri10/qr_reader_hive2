import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_reader_hive2/directions/directions.dart';
import 'package:qr_reader_hive2/home/scans_cubit/scans_cubit.dart';
import 'package:qr_reader_hive2/home/tab_cubit/tab_cubit.dart';
import 'package:qr_reader_hive2/home/widgets/widgets.dart';
import 'package:qr_reader_hive2/maps/maps.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

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
                onPressed: () {},
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
              } else if (scansState.isSuccess) {
                switch (tabState.index) {
                  case 1:
                    return const DirectionsPage();

                  default:
                    return const MapsPage();
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
