import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  final Function addNewTask;
  NewTask(this.addNewTask);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final titleTask = TextEditingController();
  DateTime selectedDate;

  void presentCalender() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  void submitTask() {
    if (titleTask.text.isEmpty || selectedDate == null) {
      return;
    }
    widget.addNewTask(
      titleTask.text,
      selectedDate,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: titleTask,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  selectedDate == null
                      ? 'no chosen date'
                      : 'picked date: ${DateFormat.yMMMEd().format(selectedDate)}',
                ),
              ),
              TextButton(
                onPressed: presentCalender,
                child: Text(
                  'choose a date',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Text('choose a date'),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
              color: Color(0xFF64FCDB),
              onPressed: submitTask,
              child: Text(
                'Add task',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
