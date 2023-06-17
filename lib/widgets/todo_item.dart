import 'package:flutter/material.dart';
import 'package:todo_list/constants/color.dart';
import 'package:todo_list/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  final onTodoChanged;
  final onDeleteItem;

  const TodoItem(
      {Key? key, required this.todo, required this.onTodoChanged, required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () => {
          onTodoChanged(todo),
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: todo.isDone ? secondaryColor : accentColor,
        leading: Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: accentButtonColor),
        title: Text(todo.title,
            style: TextStyle(
                color: primaryTextColor,
                fontSize: 16,
                decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none)),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: secondaryButtonColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            color: primaryColor,
            iconSize: 20,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
