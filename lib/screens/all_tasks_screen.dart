import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/cubit/to_do_cubit.dart';
import 'package:to_do_app/data/cubit/to_do_state.dart';
import 'package:to_do_app/screens/board/widgets/board_task_item.dart';
import 'package:to_do_app/shared/widgets/no_tasks_widget.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ToDoCubit>(context);
        if (cubit.allTasks.isEmpty) {
          return const NoTasksWidget();
        } else {
          return ListView.builder(
            itemCount: cubit.allTasks.length,
            itemBuilder: (context, index) {
              return BoardTaskItem(
                model: cubit.allTasks[index],
              );
            },
          );
        }
      },
    );
  }
}
