import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/cubit/to_do_cubit.dart';
import 'package:to_do_app/data/cubit/to_do_state.dart';
import 'package:to_do_app/data/notification.dart';
import 'package:to_do_app/screens/add_task/widgets/choose_color.dart';
import 'package:to_do_app/screens/add_task/widgets/default_textform.dart';
import 'package:to_do_app/screens/add_task/widgets/dropdownFormField.dart';
import 'package:to_do_app/shared/widgets/default_button.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ToDoCubit>(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Task'),
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    DefaultTextForm(
                      controller: cubit.titleController,
                      validator: 'Please enter a title',
                      text: 'Title',
                      hintText: 'Design team meeting',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextForm(
                      controller: cubit.dateTimeController,
                      validator: 'Please enter a date',
                      text: 'Date',
                      hintText: '2022-07-28',
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        size: 18,
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2024),
                        ).then(
                          (value) {
                            cubit.dateTimeController.text =
                                '${value!.year}-${value.month}-${value.day}';
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultTextForm(
                            controller: cubit.startTimeController,
                            validator: 'Please enter a start time',
                            text: 'Start Time',
                            hintText: '08:00 Am',
                            suffixIcon: const Icon(
                              Icons.access_time,
                              size: 18,
                            ),
                            onTap: () {
                              cubit.chooseTime(
                                  context, cubit.startTimeController);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: DefaultTextForm(
                            controller: cubit.endTimeController,
                            validator: 'Please enter an end time',
                            text: 'End Time',
                            hintText: '09:00 Pm',
                            suffixIcon: const Icon(
                              Icons.access_time,
                              size: 18,
                            ),
                            onTap: () {
                              cubit.chooseTime(
                                  context, cubit.endTimeController);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultDropdownFormField(
                      text: 'Reminder',
                      items: cubit.reminderItems,
                      hintText: '10 minutes before',
                      onChanged: (value) {
                        cubit.reminderController.text = value;
                      },
                      validator: 'Please select reminder',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultDropdownFormField(
                      text: 'Repeat',
                      items: cubit.repeatItems,
                      hintText: 'Weekly',
                      onChanged: (value) {
                        cubit.repeatController.text = value;
                      },
                      validator: 'Please select repeat type',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const ChooseColor(),
                    const SizedBox(
                      height: 30,
                    ),
                    DefaultButton(
                      text: 'Create a Task',
                      buttonColor: Colors.green.shade400,
                      textColor: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit
                              .insertToDatabase(
                            title: cubit.titleController.text,
                            startTime: cubit.startTimeController.text,
                            endTime: cubit.endTimeController.text,
                            dateTime: cubit.dateTimeController.text,
                            remind: cubit.reminderController.text,
                            repeat: cubit.repeatController.text,
                            color: cubit.selectedColor,
                          )
                              .then((value) {
                            Navigator.pop(context);
                          });
                          NotificationServices().scheduleNotifications(
                              1,
                              2,
                              cubit.titleController.text,
                              cubit.endTimeController.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
