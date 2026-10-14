import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Todo {
  String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFF9F4F0)),
      home: const MyHomePage(title: 'All Tasks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> _todos = [];
  final TextEditingController _textController = TextEditingController();

  void _saveTodo() {
    // if (_textController.text.trim().isEmpty) return;

    setState(() {
      _todos.add(Todo(title: _textController.text.trim()));
    });

    _textController.clear();
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9F4F0),
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0),
            ),

            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type to add new task...',
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];

                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 2.0),
                          ),
                        ),
                        child: CheckboxListTile(
                          value: todo.isDone,
                          onChanged: (bool? newValue) {
                            _toggleTodo(index);
                          },
                          activeColor: Color(0xFF9CE6AE),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 20,
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: todo.isDone ? Colors.grey : Colors.black,
                              fontWeight: todo.isDone
                                  ? FontWeight.w300
                                  : FontWeight.w600,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsetsGeometry.all(6.0),
        child: FloatingActionButton(
          onPressed: _saveTodo,
          shape: CircleBorder(),
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
