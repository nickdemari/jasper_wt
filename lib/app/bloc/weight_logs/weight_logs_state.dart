part of 'weight_logs_bloc.dart';

sealed class WeightLogsState extends Equatable {
  const WeightLogsState();

  @override
  List<Object> get props => [];
}

class WeightLogsInitial extends WeightLogsState {}

class WeightLogsLoading extends WeightLogsState {}

class WeightLogsLoaded extends WeightLogsState {
  final Stream<List<WeightLog>> logs;

  const WeightLogsLoaded(this.logs);
}

class WeightLogsOperationSuccess extends WeightLogsState {
  final String message;

  const WeightLogsOperationSuccess(this.message);
}

class WeightLogsError extends WeightLogsState {
  final String errorMessage;

  const WeightLogsError(this.errorMessage);
}
