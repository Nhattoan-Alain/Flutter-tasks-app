import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';
import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancleOrDeleteCallBack;
  final VoidCallback likeOrDislike;
  final VoidCallback editTaskCallBack;
  final VoidCallback restoreTaskCallBack;
  PopupMenu({
    Key? key,
    required this.task,
    required this.cancleOrDeleteCallBack,
    required this.likeOrDislike,
    required this.editTaskCallBack,
    required this.restoreTaskCallBack,
  }) : super(key: key);
  final List mycolors = <Color?>[
    Colors.green[600],
    Colors.red[400],
    Colors.grey[400],
    Colors.orange[200],
    Colors.deepPurple[200],
    Colors.teal[400],
    Colors.brown,
    Colors.lightGreen,
    Colors.pink[400],
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      constraints: const BoxConstraints.expand(
        width: 190,
        height: 220,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white70,
      ),
      itemBuilder: task.isDeleted == false
          ? ((context) => [
                PopupMenuItem(
                  onTap: null,
                  child: Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(colors: [
                          task.bgColor!,
                          task.bgColor!.withOpacity(0.7),
                          Colors.black
                        ], begin: Alignment.topLeft, end: Alignment.topRight)
                            .createShader(bounds),
                        child: const Icon(
                          Icons.edit,
                        ),
                      ),
                      TextButton(
                        onPressed: editTaskCallBack,
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: null,
                  child: PopupMenuButton(
                    child: Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(colors: [
                            task.bgColor!,
                            task.bgColor!.withOpacity(0.7),
                            Colors.black
                          ], begin: Alignment.topLeft, end: Alignment.topRight)
                              .createShader(bounds),
                          child: const Icon(
                            Icons.change_circle,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Change Color',
                        ),
                      ],
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: () {},
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < 3; i++)
                                    iconColor(context, mycolors[i]),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 3; i < 6; i++)
                                    iconColor(context, mycolors[i]),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 6; i < 9; i++)
                                    iconColor(context, mycolors[i]),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: likeOrDislike,
                  child: Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(colors: [
                          task.bgColor!,
                          task.bgColor!.withOpacity(0.7),
                          Colors.black
                        ], begin: Alignment.topLeft, end: Alignment.topRight)
                            .createShader(bounds),
                        child: task.isFavorite == false
                            ? const Icon(
                                Icons.bookmark_add_outlined,
                              )
                            : const Icon(
                                Icons.bookmark_remove,
                              ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      task.isFavorite == false
                          ? const Text(
                              'Add to \nFavorites List',
                            )
                          : const Text(
                              'Remove from \nFavorites List',
                            ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: cancleOrDeleteCallBack,
                  child: Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(colors: [
                          Colors.red,
                          Colors.red.withOpacity(0.9),
                          Colors.black
                        ], begin: Alignment.topLeft, end: Alignment.topRight)
                            .createShader(bounds),
                        child: const Icon(Icons.delete),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Delete',
                      ),
                    ],
                  ),
                ),
              ])
          : (context) => [
                PopupMenuItem(
                  onTap: restoreTaskCallBack,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.restore_from_trash),
                    label: const Text('Restore'),
                  ),
                ),
                PopupMenuItem(
                  // ignore: sort_child_properties_last
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Delete Forever'),
                  ),
                  onTap: cancleOrDeleteCallBack,
                )
              ],
    );
  }

  IconButton iconColor(BuildContext context, Color mycolor) {
    return IconButton(
      onPressed: () {
        var editedtask = Task(
          title: task.title,
          description: task.description,
          id: task.id,
          bgColor: mycolor,
          isFavorite: task.isFavorite,
          isDone: task.isDone,
          date: task.date,
        );
        context.read<TasksBloc>().add(
              ChangeColorTask(
                oldTask: task,
                newTask: editedtask,
              ),
            );
        Navigator.pop(context);
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.square,
        color: mycolor,
      ),
    );
  }
}
