import 'package:flutter/material.dart';
import 'package:flutter_bloc_tasks_app/blocs/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Task> taskListSearch = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    [
      IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back),
      )
    ];
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    String textSearch = query.toString();
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.pendingTasks + state.completedTasks;

        if (taskListSearch.isNotEmpty) {
          taskListSearch.clear();
          for (int i = 0; i < taskList.length; i++) {
            if (taskList[i]
                    .title
                    .toLowerCase()
                    .contains(textSearch.toLowerCase()) ||
                taskList[i]
                    .description
                    .toLowerCase()
                    .contains(textSearch.toLowerCase())) {
              taskListSearch.add(taskList[i]);
            }
          }
        } else {
          print("I can't see resuilt");
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [TasksList(taskList: taskListSearch)],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.pendingTasks + state.completedTasks;

        if (query.isEmpty) {
          taskListSearch.clear();
          for (int i = 0; i < taskList.length; i++) {
            if (taskList[i].title.toLowerCase().contains(query.toLowerCase()) ||
                taskList[i]
                    .description
                    .toLowerCase()
                    .contains(query.toLowerCase())) {
              taskListSearch.add(taskList[i]);
            }
          }
        } else {
          taskListSearch.clear();
          for (int i = 0; i < taskList.length; i++) {
            if (taskList[i].title.toLowerCase().contains(query.toLowerCase()) ||
                taskList[i]
                    .description
                    .toLowerCase()
                    .contains(query.toLowerCase())) {
              taskListSearch.add(taskList[i]);
            }
            if (query.length > 1 &&
                (taskList[i]
                        .title
                        .toLowerCase()
                        .contains(query.toLowerCase()) &&
                    taskList[i]
                        .description
                        .toLowerCase()
                        .contains(query.toLowerCase()))) {
              taskListSearch.clear();
              taskListSearch.add(taskList[i]);
            }
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [TasksList(taskList: taskListSearch)],
        );
      },
    );
  }
}
