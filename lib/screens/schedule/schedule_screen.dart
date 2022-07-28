import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/data/cubit/to_do_cubit.dart';
import 'package:to_do_app/data/cubit/to_do_state.dart';
import 'package:to_do_app/screens/schedule/widgets/schedule_task_item.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 16,
          ),
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<ToDoCubit>(context);
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  onDateChange: (date) {
                    cubit.setDate(date);
                    debugPrint(date.toString());
                  },
                  monthTextStyle: const TextStyle(
                    fontSize: 0,
                  ),
                  selectionColor: Colors.green.shade400,
                  selectedTextColor: Colors.white,
                  dateTextStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cubit.setCurrentWeekdayFormat(
                                  cubit.scheduleDate.toString()),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              cubit.setCurrentDateFormat(
                                  cubit.scheduleDate.toString()),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                cubit.allTasks[index]['dateTime'] ==
                                        DateFormat('yyyy-M-d')
                                            .format(cubit.scheduleDate)
                                    ? ScheduleTaskItem(
                                        task: cubit.allTasks[index],
                                      )
                                    : Container(),
                            itemCount: cubit.allTasks.length,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
