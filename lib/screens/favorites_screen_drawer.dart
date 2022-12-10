import 'package:flutter/material.dart';
import 'package:flutter_bloc_tasks_app/screens/my_drawer.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';

class FavoriteTasksScreenDrawer extends StatelessWidget {
  const FavoriteTasksScreenDrawer({Key? key}) : super(key: key);
  static const id = 'favorite_task_screen_drawer';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.favoriteTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorite Tasks'),
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${taskList.length} Favorite Tasks:',
                  ),
                ),
              ),
              TasksList(taskList: taskList)
            ],
          ),
        );
      },
    );
  }
}
