import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/model/task.dart';
import 'package:to_do_list_app/new_task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [
    Task(title: 'Go to the market', date: DateTime(2021, 1, 11), id: '123'),
    Task(title: 'Go to the beach', date: DateTime(2021, 1, 16), id: '321'),
    Task(title: 'Go to the gym', date: DateTime(2021, 1, 16), id: '321'),
  ];

  void deleteTask(String id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
  }

  void bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTask(addTask);
      },
    );
  }

  void addTask(String title, DateTime chosenDate) {
    final newTask = Task(
      title: title,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      tasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: bottomSheet,
        child: Icon(Icons.add),
      ),
      body: tasks.length == 0
          ? SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.0, right: 140, bottom: 25),
                    child: Text(
                      'My Tasks',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('image.gif'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'There are no tasks',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.0, right: 140, bottom: 30),
                    child: Text(
                      'My Tasks',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 350,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            Icons.check_box,
                            size: 35,
                            color: Color(0xFF64FCDB),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              deleteTask(tasks[index].id);
                            },
                          ),
                          title: Text(tasks[index].title),
                          subtitle: Text(
                              DateFormat.yMMMEd().format(tasks[index].date)),
                        );
                      },
                      itemCount: tasks.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
