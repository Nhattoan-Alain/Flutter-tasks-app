import 'package:flutter/material.dart';
import 'package:flutter_bloc_tasks_app/services/guid_gen.dart';
import 'package:flutter_bloc_tasks_app/widgets/build_icon_btn.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

List mycolors = <Color>[
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.orange,
  Colors.indigo,
];
Color primaryColor = mycolors[0];

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController get _titleController => titleController;
  TextEditingController get _descriptionController => descriptionController;
  @override
  void initState() {
    super.initState();
    _titleController;
    _descriptionController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Add Task',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              label: Text('Description'),
              border: OutlineInputBorder(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 30,
              right: 10,
            ),
            child: Row(
              children: [
                for (var i = 0; i < 6; i++)
                  BuildIconBtn(
                    mycolor: mycolors[i],
                    changeColor: () {
                      setState(() {
                        primaryColor = mycolors[i];
                      });
                    },
                    primaryColor: primaryColor,
                  )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'cancle',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  var task = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    id: GUIDGen.generate(),
                    date: DateTime.now().toString(),
                    bgColor: primaryColor,
                  );
                  context.read<TasksBloc>().add(
                        AddTask(task: task),
                      );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   primaryColor;
  //   super.dispose();
  //   //...
  // }
}
