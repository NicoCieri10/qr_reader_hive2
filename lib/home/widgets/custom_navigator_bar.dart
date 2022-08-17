import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_reader_hive2/home/tab_cubit/tab_cubit.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tabCubit = context.read<TabCubit>();

    return BlocBuilder<TabCubit, TabState>(
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: tabCubit.changeTab,
          currentIndex: state.index,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Mapa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration),
              label: 'Direcciones',
            ),
          ],
        );
      },
    );
  }
}
