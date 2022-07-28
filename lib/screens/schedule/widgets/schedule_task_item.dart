import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/cubit/to_do_cubit.dart';
import 'package:to_do_app/data/cubit/to_do_state.dart';

class ScheduleTaskItem extends StatelessWidget {
  final Map task;
  const ScheduleTaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String stringColor = task['color'].split('(0x')[1].split(')')[0];
    int intColor = int.parse(stringColor, radix: 16);
    Color color = Color(intColor);
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ToDoCubit>(context);
        return Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task['startTime'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          task['title'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          value: task['status'] == 'completed' ? true : false,
                          checkColor: Colors.white,
                          activeColor: color,
                          onChanged: (value) {
                            if (value! == true) {
                              cubit.updateTaskStatus(
                                model: task,
                                status: task['status'] == 'completed'
                                    ? 'uncompleted'
                                    : 'completed',
                              );
                            } else {
                              cubit.updateTaskStatus(
                                model: task,
                                status: task['status'] == 'uncompleted'
                                    ? 'completed'
                                    : 'uncompleted',
                              );
                            }
                          },
                          shape: const CircleBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
