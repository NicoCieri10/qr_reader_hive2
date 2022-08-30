part of 'scans_cubit.dart';

abstract class ScansState extends Equatable {
  const ScansState();

  bool get isInitial => this is ScansInitial;
  bool get isLoading => this is ScansLoading;
  bool get isSuccess => this is ScansSuccessful;
  bool get isFailure => this is ScansFailure;

  @override
  List<Object?> get props => [];
}

class ScansInitial extends ScansState {}

class ScansLoading extends ScansState {}

class ScansSuccessful extends ScansState {
  const ScansSuccessful({
    required this.scans,
  });

  final List<ScanModel>? scans;

  List<ScanModel>? get geoScans =>
      scans?.where((scan) => scan.type == ScanModelType.geo).toList();

  List<ScanModel>? get httpScans =>
      scans?.where((scan) => scan.type != ScanModelType.geo).toList();

  ScansSuccessful copyWith({List<ScanModel>? scans}) {
    return ScansSuccessful(
      scans: scans ?? this.scans,
    );
  }

  @override
  List<Object?> get props => [scans];
}

class ScansFailure extends ScansState {}
