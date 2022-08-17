part of 'tab_cubit.dart';

class TabState extends Equatable {
  const TabState({
    this.index = 0,
  });

  final int index;

  @override
  List<Object?> get props => [index];
}
