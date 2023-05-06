import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoTile extends StatelessWidget {
  final String task;
  final bool value;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? onPressedSlidable;

  const ToDoTile(
      {super.key,
      required this.task,
      required this.value,
      required this.onChanged,
      required this.onPressedSlidable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onPressedSlidable,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(11),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow.shade400,
              borderRadius: BorderRadius.circular(11)),
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Checkbox(
                  value: value,
                  onChanged: onChanged,
                  activeColor: Colors.black),
              const SizedBox(
                width: 20,
              ),
              Text(
                task,
                style:GoogleFonts.montserrat(fontSize: 20 ,
                fontWeight: FontWeight.w400 ,
                  decoration:
                      value ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
