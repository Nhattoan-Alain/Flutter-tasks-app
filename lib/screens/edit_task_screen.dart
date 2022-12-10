import 'package:flutter/material.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class EditTaskScreen extends StatefulWidget {
  final Task oldTask;
  const EditTaskScreen({
    Key? key,
    required this.oldTask,
  }) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

List mycolors = <Color>[
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.orange,
  Colors.indigo,
];

class _EditTaskScreenState extends State<EditTaskScreen> {
  Color newprimaryColor = mycolors[0];
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(
      text: widget.oldTask.title,
    );
    TextEditingController descriptionController = TextEditingController(
      text: widget.oldTask.description,
    );

    @override
    // ignore: unused_element
    void initState() {
      super.initState();
      titleController;
      descriptionController;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Edit Task',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
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
                  buildIconBtn(
                    mycolors[i],
                  ),
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
                  var editedtask = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    id: widget.oldTask.id,
                    bgColor: newprimaryColor,
                    isFavorite: widget.oldTask.isFavorite,
                    isDone: false,
                    date: DateTime.now().toString(),
                  );
                  context.read<TasksBloc>().add(
                        EditTask(
                          oldTask: widget.oldTask,
                          newTask: editedtask,
                        ),
                      );
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Stack buildIconBtn(Color mycolor) {
    return Stack(
      children: [
        Positioned(
          top: 4.5,
          left: 4.5,
          child: Icon(Icons.circle,
              size: 40,
              color: newprimaryColor == mycolor
                  ? mycolor.withOpacity(0.6)
                  : Colors.transparent),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              newprimaryColor = mycolor;
            });
          },
          child: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.circle,
              size: 30,
              color: mycolor,
            ),
          ),
        ),
      ],
    );
  }
}
