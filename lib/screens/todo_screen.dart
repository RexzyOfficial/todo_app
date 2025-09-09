import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../widgets/todo_item.dart';
import 'login_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _controller = TextEditingController();
  final _firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final uid = auth.user!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My ToDo List"),
        actions: [
          IconButton(
            onPressed: () async {
              await auth.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: "Enter new task..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    if (_controller.text.isNotEmpty) {
                      await _firestore.addTodo(uid, _controller.text.trim());
                      _controller.clear();
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.getTodos(uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) return const Center(child: Text("No tasks yet"));
                return ListView(
                  children: docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return TodoItem(
                      id: doc.id,
                      title: data['title'] ?? '',
                      isDone: data['isDone'] ?? false,
                      onToggle: (val) => _firestore.toggleTodo(uid, doc.id, val),
                      onDelete: () => _firestore.deleteTodo(uid, doc.id),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
