import 'package:flutter/material.dart';
import 'package:flutter_bloc_tasks_app/screens/favorite_tasks_screen.dart';
import 'package:flutter_bloc_tasks_app/screens/favorites_screen_drawer.dart';
import 'package:flutter_bloc_tasks_app/screens/recycle_bin.dart';
import 'package:flutter_bloc_tasks_app/screens/tabs_screen.dart';

import '../blocs/bloc_exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          topRight: Radius.circular(15),
        )),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(15))),
              child: const Text(
                'Task Drawer',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(TabsScreen.id);
                  },
                  child: ListTile(
                    leading: ShaderMask(
                      shaderCallback: (bounds) {
                        Gradient gradient = LinearGradient(colors: [
                          Colors.red,
                          Colors.red.withOpacity(0.85),
                          Colors.orange
                        ], begin: Alignment.topLeft, end: Alignment.topRight);
                        return gradient.createShader(bounds);
                      },
                      child: const Icon(
                        Icons.folder_special,
                      ),
                    ),
                    title: const Text(
                      'My Tasks',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Text(
                        ' ${state.pendingTasks.length} | ${state.completedTasks.length} completed'),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(FavoriteTasksScreenDrawer.id);
                },
                child: ListTile(
                  leading: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(colors: [
                      Colors.pink,
                      Colors.pink.withOpacity(0.6),
                      Colors.black
                    ], begin: Alignment.topLeft, end: Alignment.topRight)
                        .createShader(bounds),
                    child: const Icon(Icons.favorite),
                  ),
                  title: const Text(
                    'Favorites',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  trailing: Text('${state.favoriteTasks.length}'),
                ),
              );
            }),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(RecycleBin.id);
                  },
                  child: ListTile(
                    leading: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(colors: [
                        Colors.red,
                        Colors.red.withOpacity(0.7),
                        Colors.black
                      ], begin: Alignment.topLeft, end: Alignment.topRight)
                          .createShader(bounds),
                      child: const Icon(Icons.delete),
                    ),
                    title: const Text(
                      'Bin',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    trailing: Text('${state.removeTasks.length}'),
                  ),
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                  inactiveTrackColor: Colors.grey.shade400.withOpacity(0.5),
                  value: state.switchValue,
                  onChanged: (newValue) {
                    newValue
                        ? context.read<SwitchBloc>().add(SwitchOnEvent())
                        : context.read<SwitchBloc>().add(SwitchOffEvent());
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
