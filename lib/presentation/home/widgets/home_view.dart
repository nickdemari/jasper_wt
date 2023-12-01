import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jasper_wt/app/bloc/authentication/app_bloc.dart';
import 'package:jasper_wt/app/bloc/weight_logs/weight_logs_bloc.dart';
import 'package:jasper_wt/data/models/weight_log.dart';
import 'package:uuid/uuid.dart';

import 'package:timeago/timeago.dart' as timeago;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<WeightLogsBloc>(context).add(WeightLogsLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WeightLogsBloc weightLogsBloc =
        BlocProvider.of<WeightLogsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AppBloc>(context).add(AppLogoutRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<WeightLogsBloc, WeightLogsState>(
        builder: (context, state) {
          switch (state) {
            case WeightLogsLoading():
              return const Center(child: CircularProgressIndicator());
            case WeightLogsLoaded():
              final weightLogs = state.logs;
              return StreamBuilder(
                stream: weightLogs,
                builder: (context, AsyncSnapshot<List<WeightLog>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        final logs = snapshot.data;
                        return ListView.builder(
                          itemCount: logs!.length,
                          itemBuilder: (context, index) {
                            final log = logs[index];
                            return ListTile(
                              title: Text(log.weight.toString()),
                              subtitle: Text(
                                timeago.format(
                                  log.dateTime.toDate(),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _showEditItemialog(context, log);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      weightLogsBloc.add(WeightLogsDelete(log));
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                  }
                },
              );
            case WeightLogsOperationSuccess():
              weightLogsBloc.add(WeightLogsLoad());
              return Container();
            case WeightLogsError():
              return Center(child: Text(state.errorMessage));
            default:
              return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // I'd like to refactor this into it's own bloc.
  void _showEditItemialog(BuildContext context, WeightLog log) {
    final titleController = TextEditingController(text: log.weight.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit weight log'),
          content: TextField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'eg. 70.5',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                final weightLog = log.copyWith(
                  weight: double.parse(titleController.value.text),
                );
                BlocProvider.of<WeightLogsBloc>(context)
                    .add(WeightLogsUpdate(weightLog));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // I'd like to refactor this into it's own bloc.
  void _showAddItemDialog(BuildContext context) {
    final titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add weight log'),
          content: TextField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'eg. 70.5',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                final weightLog = WeightLog(
                  id: const Uuid().v4(),
                  weight: double.parse(titleController.value.text),
                  dateTime: Timestamp.now(),
                );
                BlocProvider.of<WeightLogsBloc>(context)
                    .add(WeightLogsCreate(weightLog));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
