import 'package:flutter/material.dart';
import 'package:flutter_bloc_tasks_app/screens/add_task_screen.dart';

class BuildIconBtn extends StatefulWidget {
  Color primaryColor;
  Color mycolor;
  final VoidCallback changeColor;

  BuildIconBtn({
    super.key,
    required this.mycolor,
    required this.changeColor,
    required this.primaryColor,
  });

  @override
  State<BuildIconBtn> createState() => _BuildIconBtnState();
}

class _BuildIconBtnState extends State<BuildIconBtn> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 4.5,
          left: 4.5,
          child: Icon(Icons.circle,
              size: 40,
              color: primaryColor == widget.mycolor
                  ? widget.mycolor.withOpacity(0.6)
                  : Colors.transparent),
        ),
        GestureDetector(
          onTap: widget.changeColor,
          child: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.circle,
              size: 30,
              color: widget.mycolor,
            ),
          ),
        ),
      ],
    );
  }
}
