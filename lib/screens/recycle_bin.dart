import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/tasks_list.dart';
import 'my_drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {},
                          child: TextButton.icon(
                            onPressed: () {
                              state.removeTasks.isNotEmpty
                                  ? showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Are you sure to delete all tasks"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancle',
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                  )),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                context
                                                    .read<TasksBloc>()
                                                    .add(DeleteAllTasks());
                                              },
                                              child: const Text('OK',
                                                  style: TextStyle(
                                                    color: Colors.blueAccent,
                                                  )),
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  : showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: AlertDialog(
                                            title: const Center(
                                                child: Text(
                                              "Remove taskslist is empty!",
                                              style: TextStyle(
                                                  color: Colors.orangeAccent),
                                            )),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('OK',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                            },
                            icon: const Icon(Icons.clear_all_rounded),
                            label: const Text('Delete all tasks'),
                          ),
                        )
                      ])
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    ' ${state.removeTasks.length}Tasks:',
                  ),
                ),
              ),
              TasksList(taskList: state.removeTasks)
            ],
          ),
        );
      },
    );
  }
}
