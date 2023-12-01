part of 'weight_logs_bloc.dart';

sealed class WeightLogsEvent extends Equatable {
  const WeightLogsEvent();

  @override
  List<Object> get props => [];
}

class WeightLogsLoad extends WeightLogsEvent {}

class WeightLogsCreate extends WeightLogsEvent {
  final WeightLog log;

  const WeightLogsCreate(this.log);

  @override
  List<Object> get props => [log];

  @override
  String toString() => 'WeightLogsCreate { log: $log }';
}

class WeightLogsUpdate extends WeightLogsEvent {
  final WeightLog log;

  const WeightLogsUpdate(this.log);

  @override
  List<Object> get props => [log];

  @override
  String toString() => 'WeightLogsUpdate { log: $log }';
}

class WeightLogsDelete extends WeightLogsEvent {
  final WeightLog log;

  const WeightLogsDelete(this.log);

  @override
  List<Object> get props => [log];

  @override
  String toString() => 'WeightLogsDelete { log: $log }';
}
