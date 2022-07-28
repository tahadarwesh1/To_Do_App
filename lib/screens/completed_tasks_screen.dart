import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/cubit/to_do_cubit.dart';
import 'package:to_do_app/data/cubit/to_do_state.dart';
import 'package:to_do_app/screens/board/widgets/board_task_item.dart';
import 'package:to_do_app/shared/widgets/no_tasks_widget.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ToDoCubit>(context);
        if (cubit.completedTasks.isEmpty) {
          return const NoTasksWidget();
        } else {
          return ListView.builder(
            itemCount: cubit.completedTasks.length,
            itemBuilder: (context, index) {
              return BoardTaskItem(
                model: cubit.completedTasks[index],
              );
            },
          );
        }
      },
    );
  }
}
