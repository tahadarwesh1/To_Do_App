import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/cubit/to_do_cubit.dart';
import 'package:to_do_app/data/cubit/to_do_state.dart';
import 'package:to_do_app/screens/add_task/add_task_screen.dart';
import 'package:to_do_app/screens/all_tasks_screen.dart';
import 'package:to_do_app/screens/completed_tasks_screen.dart';
import 'package:to_do_app/screens/favorite_tasks_screen.dart';
import 'package:to_do_app/screens/schedule/schedule_screen.dart';
import 'package:to_do_app/screens/uncompleted_tasks_screen.dart';
import 'package:to_do_app/shared/components.dart';
import 'package:to_do_app/shared/widgets/default_button.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ToDoCubit>(context);
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Board'),
              actions: [
                IconButton(
                  padding: const EdgeInsets.only(right: 16),
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () {
                    navigateTo(context, const ScheduleScreen());
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    child: TabBar(
                      tabs: cubit.tabs,
                      indicatorColor: Colors.black,
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        AllTasksScreen(),
                        CompletedTasksScreen(),
                        UncompletedTasksScreen(),
                        FavoriteTasksScreen(),
                      ],
                    ),
                  ),
                  DefaultButton(
                    text: 'Add Task',
                    buttonColor: Colors.green.shade400,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddTaskScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
