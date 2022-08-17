import 'package:bloc/bloc.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:equatable/equatable.dart';

part 'scans_state.dart';

class ScansCubit extends Cubit<ScansState> {
  ScansCubit({
    required DataPersistence dataPersistence,
  })  : _dataPersistence = dataPersistence,
        super(ScansInitial());

  /// This method is used to get the scans and load it in the state.
  void getScans() {
    emit(ScansLoading());
    try {
      final scans = _dataPersistence.scans;

      emit(ScansSuccessful(scans: scans));
    } catch (_) {
      emit(ScansFailure());
    }
  }

  Future<void> createScan(String value) async {
    final _state = state;
    if (_state is! ScansSuccessful) return;
    emit(ScansLoading());
    try {
      final id = await _dataPersistence.addScan(value);
      final scans = _dataPersistence.scans;
      emit(
        _state.copyWith(scans: scans),
      );
    } catch (_) {
      emit(ScansFailure());
    }
  }

  final DataPersistence _dataPersistence;
}
