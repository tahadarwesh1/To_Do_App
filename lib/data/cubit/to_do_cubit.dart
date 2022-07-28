import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/data/cubit/to_do_state.dart';

class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(ToDoInitialState());
  static String get(context) => BlocProvider.of(context);

  List<Widget> tabs = [
    const Tab(
      text: 'All',
    ),
    const Tab(
      text: 'Completed',
    ),
    const Tab(
      text: 'Uncompleted',
    ),
    const Tab(
      text: 'Favorites',
    ),
  ];
  // String dropdownValue() {
  //   int i;
  //   for (i = 0; i < reminderItems.length-1; i++) {
  //     if (reminderItems[i] == reminderController.text) {}
  //   }
  //   return reminderItems[i].value;
  // }

  List<DropdownMenuItem> reminderItems = [
    const DropdownMenuItem<String>(
      value: '10 min before',
      child: Text('10 min before'),
    ),
    const DropdownMenuItem<String>(
      value: '30 min before',
      child: Text('30 min before'),
    ),
    const DropdownMenuItem<String>(
      value: '1 hour before',
      child: Text('1 hour before'),
    ),
    const DropdownMenuItem<String>(
      value: '1 day before',
      child: Text('1 day before'),
    ),
  ];

  List<DropdownMenuItem> repeatItems = [
    const DropdownMenuItem<String>(
      value: 'Daily',
      child: Text('Daily'),
    ),
    const DropdownMenuItem<String>(
      value: 'Weekly',
      child: Text('Weekly'),
    ),
    const DropdownMenuItem<String>(
      value: 'Monthly',
      child: Text('Monthly'),
    ),
  ];

  DateTime scheduleDate = DateTime.now();

  String setDate(DateTime date) {
    scheduleDate = date;

    emit(ScheduleDateState());
    return DateFormat('dd MMM, yyyy').format(scheduleDate);
  }

  String setCurrentDateFormat(String date) {
    String currentDateFormat = DateFormat('dd MMM, yyyy').format(scheduleDate);
    date = currentDateFormat;
    return currentDateFormat;
  }

  String setCurrentWeekdayFormat(String date) {
    String currentDateFormat = DateFormat().add_EEEE().format(scheduleDate);
    date = currentDateFormat;
    return currentDateFormat;
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController reminderController = TextEditingController();
  TextEditingController repeatController = TextEditingController();

  Color selectedColor = Colors.green.shade400;
  List<Color> colors = [
    const Color(0xffFFA500),
    const Color(0xffb74093),
    const Color(0xff00FF00),
    const Color(0xff00FFFF),
    const Color(0xffFF00FF),
  ];

  void changeColor(Color hexColor) {
    selectedColor = hexColor;
    debugPrint('selectedColor: $selectedColor');
    emit(ChangeColorState());
  }

  TimeOfDay initialTime = TimeOfDay.now();
  void chooseTime(BuildContext context, TextEditingController controller) {
    showTimePicker(
      context: context,
      initialTime: initialTime,
    ).then(
      (value) {
        controller.text =
            '${value!.hour > 12 ? value.hour - 12 : value.hour}:${value.minute} ${value.hour > 12 ? 'PM' : 'AM'}';
      },
    );
  }

  List<Map> allTasks = [];
  List<Map> uncompletedTasks = [];
  List<Map> completedTasks = [];
  List<Map> favoriteTasks = [];
  Database? database;

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint('database created');

        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, dateTime TEXT, startTime TEXT, endTime TEXT, reminder TEXT, repeat TEXT, color BLOB, status TEXT, is_favorite TEXT)')
            .then((value) {
          debugPrint('table created ');
        }).catchError((error) {
          debugPrint('Error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        debugPrint('database opened');

        getDataFromDatabase(database);
        debugPrint(database.toString());
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseSuccessState());
    });
  }

  void getDataFromDatabase(database) {
    allTasks = [];
    uncompletedTasks = [];
    completedTasks = [];
    favoriteTasks = [];

    emit(GetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        allTasks.add(element);

        if (element['status'] == 'uncompleted') {
          uncompletedTasks.add(element);
        } else if (element['status'] == 'completed') {
          completedTasks.add(element);
        } else if (element['status'] == 'favorite') {
          favoriteTasks.add(element);
        }
      });
      print(allTasks);
      emit(GetDatabaseSuccessState());
    });
  }

  insertToDatabase({
    required String title,
    required String dateTime,
    required String startTime,
    required String endTime,
    required String remind,
    required String repeat,
    required Color color,
    String status = 'uncompleted',
    bool isFavorite = false,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, dateTime, startTime, endTime, reminder, repeat, color, status, is_favorite) VALUES("$title","$dateTime","$startTime","$endTime","$remind", "$repeat","$color","$status","$isFavorite")')
          .then((value) {
        debugPrint('$value is inserting successfully');
        emit(InsertDatabaseSuccessState());
        getDataFromDatabase(database);
      }).catchError((error) {
        debugPrint('Error when Insert new raw Record ${error.toString()}');
      });
    });
  }

  void updateTaskStatus({
    required Map model,
    required String status,
  }) {
    database!
        .rawUpdate(
            'UPDATE tasks SET status = "$status" WHERE id = "${model['id']}"')
        .then((value) {
      print('${model['title']} is updated successfully');
      getDataFromDatabase(database);
      emit(ChangeTaskStatusSuccessState());
    });
  }


  void deleteFromDataBase({
    required int id,
  }) async {
    await database!
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(DeleteTaskSuccessState());
    });
  }
}
