import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc_tasks_app/widgets/popup_menu.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../screens/edit_task_screen.dart';

class TaskTitle extends StatelessWidget {
  const TaskTitle({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;
  void _removeOrDeleteTasks(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(
            oldTask: task,
          ),
        ),
      ),
    );
  }

  void showSnackBarFavorite(
      BuildContext context, bool? isFavorite, bool? isDeleted) {
    isDeleted == true
        ? Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.transparent.withOpacity(0.9),
            icon: const Icon(
              Icons.error,
              color: Colors.redAccent,
              size: 20,
            ),
            titleText: const Text(
              'Error',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            message: "Oops! It was deleted",
            duration: const Duration(milliseconds: 800),
            leftBarIndicatorColor: Colors.red.withOpacity(0.7),
          ).show(context)
        : isFavorite == false
            ? Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                margin: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(10),
                backgroundGradient:
                    const LinearGradient(colors: [Colors.red, Colors.orange]),
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 20,
                ),
                titleText: const Text(
                  'Add favorite task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                message: "Add to favorite task",
                duration: const Duration(seconds: 1),
              ).show(context)
            : Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                margin: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(10),
                backgroundGradient:
                    const LinearGradient(colors: [Colors.black, Colors.pink]),
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.orange.withOpacity(0.7),
                  size: 20,
                ),
                titleText: const Text(
                  'Remove favorite task',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                message: "Task from favorite task have been removed",
                duration: const Duration(seconds: 1),
              ).show(context);
  }

  void showSnackBar(BuildContext context, bool? isDone, bool? isDeleted) {
    isDeleted == true
        ? Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.transparent.withOpacity(0.9),
            icon: const Icon(
              Icons.error,
              color: Colors.redAccent,
              size: 20,
            ),
            titleText: const Text(
              'Error',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            message: "Oops! It was deleted",
            duration: const Duration(milliseconds: 800),
            leftBarIndicatorColor: Colors.red.withOpacity(0.7),
          ).show(context)
        : isDone == false
            ? Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                margin: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(10),
                backgroundGradient: LinearGradient(colors: [
                  Colors.green,
                  Colors.green.withOpacity(0.5),
                  Colors.white
                ]),
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
                titleText: const Text(
                  'Completed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                message: "You have completed",
                duration: const Duration(milliseconds: 800),
              ).show(context)
            : Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                margin: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(10),
                backgroundGradient:
                    const LinearGradient(colors: [Colors.black, Colors.orange]),
                icon: Icon(
                  Icons.restore,
                  color: Colors.orange.withOpacity(0.7),
                  size: 20,
                ),
                titleText: const Text(
                  'Restore',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                message: "Task have been restored",
                duration: const Duration(milliseconds: 800),
              ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: const Color(0xFF212121),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Detail Task:",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.9),
                  ),
                  const Text(
                    "Title:",
                    style: TextStyle(
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Description:",
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    task.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Time:",
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat()
                        .add_yMMMd()
                        .add_Hms()
                        .format(DateTime.parse(task.date)),
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9), fontSize: 18),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              task.bgColor!,
              task.bgColor!.withOpacity(0.7),
              Colors.black.withOpacity(0.7)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: task.isDone == false
                          ? const Icon(Icons.done_outline,
                              color: Colors.white70)
                          : const Icon(Icons.restore_outlined,
                              color: Colors.white70),
                      onPressed: () {
                        task.isDeleted == false
                            ? context.read<TasksBloc>().add(
                                  UpdateTask(task: task),
                                )
                            : null;
                        showSnackBar(
                          context,
                          task.isDone,
                          task.isDeleted,
                        );
                      },
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            task.isDeleted == false
                                ? context.read<TasksBloc>().add(
                                    MarkFavoriteOrUbFavoriteTask(task: task))
                                : null;
                            showSnackBarFavorite(
                              context,
                              task.isFavorite,
                              task.isDeleted,
                            );
                          },
                          child: task.isFavorite == false
                              ? const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white70,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  color: Colors.white70,
                                ),
                        ),
                        PopupMenu(
                          task: task,
                          cancleOrDeleteCallBack: () => _removeOrDeleteTasks(
                            context,
                            task,
                          ),
                          likeOrDislike: () {
                            context
                                .read<TasksBloc>()
                                .add(MarkFavoriteOrUbFavoriteTask(task: task));
                          },
                          editTaskCallBack: () {
                            Navigator.of(context).pop();
                            _editTask(context);
                          },
                          restoreTaskCallBack: () {
                            context.read<TasksBloc>().add(
                                  RestoreTask(task: task),
                                );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.only(left: 6),
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                    Text(
                      DateFormat()
                          .add_yMMMd()
                          .add_Hms()
                          .format(DateTime.parse(task.date)),
                      style: TextStyle(color: Colors.white.withOpacity(0.9)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 68,
                      width: 165,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                task.description,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 18,
                                    decoration: task.isDone!
                                        ? TextDecoration.lineThrough
                                        : null),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //
            ],
          ),
        ),
      ),
    );
  }
}
