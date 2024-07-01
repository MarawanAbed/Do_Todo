import 'package:do_todo/custom_button.dart';
import 'package:do_todo/todo_model.dart';
import 'package:flutter/material.dart';

class NotesItems extends StatelessWidget {
  const NotesItems({
    super.key,
    required this.todoModel,
  });

  final TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(30),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  CustomButton(
                    title: 'Task Completed',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'Edit Task',
                    onPressed: () {},
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'Delete Task',
                    onPressed: () {},
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'Close',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(todoModel.color),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todoModel.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${todoModel.startTime} - ${todoModel.endTime}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    todoModel.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 50,
              width: 1,
              color: Colors.white,
            ),
            Transform.rotate(
              angle: 3.14 / 0.67,
              child: const Text(
                'TODO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
