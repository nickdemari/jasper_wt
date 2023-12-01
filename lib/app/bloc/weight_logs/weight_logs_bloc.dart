import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jasper_wt/data/repositories/log_repository.dart';

import '../../../data/models/weight_log.dart';

part 'weight_logs_event.dart';
part 'weight_logs_state.dart';

class WeightLogsBloc extends Bloc<WeightLogsEvent, WeightLogsState> {
  final LogRepository _logRepository;

  WeightLogsBloc({required LogRepository logRepository})
      : _logRepository = LogRepository(),
        super(WeightLogsInitial()) {
    on<WeightLogsLoad>(_onLoad);
    on<WeightLogsCreate>(_onCreate);
    on<WeightLogsUpdate>(_onUpdate);
    on<WeightLogsDelete>(_onDelete);
  }

  void _onLoad(WeightLogsLoad event, Emitter<WeightLogsState> emit) async {
    try {
      emit(WeightLogsLoading());
      final logs = _logRepository.getLogs();
      emit(WeightLogsLoaded(logs));
    } catch (e) {
      emit(WeightLogsError(e.toString()));
    }
  }

  void _onCreate(WeightLogsCreate event, Emitter<WeightLogsState> emit) async {
    try {
      await _logRepository.addLog(event.log.toJson());
      emit(const WeightLogsOperationSuccess('Log created successfully'));
    } catch (e) {
      emit(WeightLogsError(e.toString()));
    }
  }

  void _onUpdate(WeightLogsUpdate event, Emitter<WeightLogsState> emit) async {
    try {
      await _logRepository.updateLog(event.log.toJson(), event.log.id);
      emit(const WeightLogsOperationSuccess('Log updated successfully'));
    } catch (e) {
      emit(WeightLogsError(e.toString()));
    }
  }

  void _onDelete(WeightLogsDelete event, Emitter<WeightLogsState> emit) async {
    try {
      await _logRepository.deleteLog(event.log.id);
      emit(const WeightLogsOperationSuccess('Log deleted successfully'));
    } catch (e) {
      emit(WeightLogsError(e.toString()));
    }
  }
}
