import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/cubit/to_do_cubit.dart';
import 'package:to_do_app/data/cubit/to_do_state.dart';

class ChooseColor extends StatelessWidget {
  const ChooseColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ToDoCubit>(context);
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Color",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Wrap(
                  children: List<Widget>.generate(
                    cubit.colors.length,
                    (int index) {
                      return GestureDetector(
                        onTap: () {
                          cubit.changeColor(cubit.colors[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: cubit.colors[index],
                            child: cubit.selectedColor == cubit.colors[index]
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                : Container(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
