import 'package:bloc/bloc.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:equatable/equatable.dart';

part 'scans_state.dart';

abstract class ScansCubitBase {
  /// This method is used to get the scans and load it in the state.
  void getScans();

  /// This method is used to add a new scan to the state.
  Future<void> createScan(String value);

  /// This method is used to delete a scan from the state.
  Future<void> deleteScan(ScanModel scan);
}

class ScansCubit extends Cubit<ScansState> implements ScansCubitBase {
  ScansCubit({
    required DataPersistence dataPersistence,
  })  : _dataPersistence = dataPersistence,
        super(ScansInitial());

  @override
  void getScans() {
    emit(ScansLoading());
    try {
      final scans = _dataPersistence.scans;

      emit(ScansSuccessful(scans: scans));
    } catch (_) {
      emit(ScansFailure());
    }
  }

  @override
  Future<void> createScan(String value) async {
    final _state = state;
    if (_state is! ScansSuccessful) return;
    try {
      await _dataPersistence.addScan(value);
      final scans = _dataPersistence.scans;
      emit(
        _state.copyWith(scans: scans),
      );
    } catch (_) {
      emit(ScansFailure());
    }
  }

  @override
  Future<void> deleteScan(ScanModel scan) async {
    final _state = state;
    if (_state is! ScansSuccessful) return;
    try {
      await _dataPersistence.deleteScanById(scan.id);
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
