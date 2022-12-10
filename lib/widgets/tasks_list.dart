import 'package:flutter/material.dart';

import '../models/task.dart';
import 'task_title.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: taskList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (context, index) {
          var task = taskList[index];
          return TaskTitle(task: task);
        },
      ),
    );
  }
}



// Expanded(
//       child: SingleChildScrollView(
//         child: ExpansionPanelList.radio(
//           children: taskList
//               .map((task) => ExpansionPanelRadio(
//                     value: task.id,
//                     headerBuilder: (context, isOpen) => TaskTitle(task: task),
//                     body: ListTile(
//                       title: SelectableText.rich(TextSpan(children: [
//                         const TextSpan(
//                             text: 'Text:\n ',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             )),
//                         TextSpan(text: task.title),
//                         const TextSpan(
//                             text: '\n\nDescription:\n ',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             )),
//                         TextSpan(text: task.description)
//                       ])),
//                     ),
//                   ))
//               .toList(),
//         ),
//       ),
//     );