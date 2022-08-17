import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(const TabState());

  /// This method is used to change the state of the tab.
  void changeTab(int index) {
    // If the tab is different from the current tab, emit a new state.
    if (state.index != index) emit(TabState(index: index));
  }
}
