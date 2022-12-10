import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_bloc_tasks_app/models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUbFavoriteTask>(_onMarkFavoriteOrUbFavoriteTask);
    on<EditTask>(_onEditTask);
    on<ChangeColorTask>(_onChangeColorTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: List.from(state.completedTasks),
      favoriteTasks: List.from(state.favoriteTasks),
      removeTasks: state.removeTasks,
    ));
  }

  //
  // pendingTasks.clear();
  // for (int i = 0; i < pendingTasks.length; i++) {
  //   if (pendingTasks[i].description.contains(event.task.toString())) {
  //     List.from(pendingTasks)
  //       .insert(i, pendingTasks[i]);
  //   }
  // }
  //

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (task.isDone == false) {
      if (task.isFavorite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(
          0,
          task.copyWith(isDone: true),
        );
      } else {
        var taskIndex = favoriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(
          0,
          task.copyWith(isDone: true),
        );
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(
            taskIndex,
            task.copyWith(isDone: true),
          );
      }
    } else {
      if (task.isFavorite == false) {
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks.insert(
          0,
          task.copyWith(isDone: false),
        );
      } else {
        var taskIndex = favoriteTasks.indexOf(task);
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks.insert(
          0,
          task.copyWith(isDone: false),
        );
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(
            taskIndex,
            task.copyWith(
              isDone: false,
            ),
          );
      }
    }
    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      removeTasks: state.removeTasks,
      favoriteTasks: favoriteTasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removeTasks: List.from(state.removeTasks)..remove(event.task),
      ),
    );
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          pendingTasks: List.from(state.pendingTasks)..remove(event.task),
          completedTasks: List.from(state.completedTasks)..remove(event.task),
          favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
          removeTasks: List.from(state.removeTasks)
            ..add(event.task.copyWith(isDeleted: true))),
    );
  }

  void _onMarkFavoriteOrUbFavoriteTask(
      MarkFavoriteOrUbFavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: true),
          );
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: false),
          );
        favoriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: true),
          );
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: false),
          );
        favoriteTasks.remove(event.task);
      }
    }
    emit(
      TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removeTasks: state.removeTasks,
      ),
    );
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(
          0,
          event.newTask,
        );
    }
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(
          0,
          event.newTask,
        ),
      completedTasks: state.completedTasks..remove(event.oldTask),
      removeTasks: state.removeTasks,
      favoriteTasks: favoriteTasks,
    ));
  }

  void _onChangeColorTask(ChangeColorTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favoriteTask = state.favoriteTasks;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    if (event.oldTask.isFavorite == true) {
      var taskIndex = favoriteTask.indexOf(event.oldTask);
      favoriteTask = List.from(favoriteTask)
        ..remove(event.oldTask)
        ..insert(taskIndex, event.newTask);
    }
    if (event.oldTask.isDone == true) {
      var taskIndex = completedTasks.indexOf(event.oldTask);
      completedTasks = List.from(completedTasks)
        ..remove(event.oldTask)
        ..insert(taskIndex, event.newTask);
    } else {
      var taskIndex = pendingTasks.indexOf(event.oldTask);
      pendingTasks = List.from(pendingTasks)
        ..remove(event.oldTask)
        ..insert(taskIndex, event.newTask);
    }

    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTask,
        removeTasks: state.removeTasks));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removeTasks: state.removeTasks..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(
            0,
            event.task.copyWith(
              isDeleted: false,
              isDone: false,
              isFavorite: false,
            ),
          ),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removeTasks: List.from(state.removeTasks)..clear(),
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
