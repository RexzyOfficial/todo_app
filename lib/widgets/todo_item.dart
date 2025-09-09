import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String id;
  final String title;
  final bool isDone;
  final Function(bool) onToggle;
  final Function() onDelete;

  const TodoItem({
    super.key,
    required this.id,
    required this.title,
    required this.isDone,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Checkbox(value: isDone, onChanged: (val) => onToggle(val!)),
        title: Text(title, style: TextStyle(decoration: isDone ? TextDecoration.lineThrough : null)),
        trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
      ),
    );
  }
}
