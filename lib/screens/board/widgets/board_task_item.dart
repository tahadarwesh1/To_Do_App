import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/cubit/to_do_cubit.dart';
import 'package:to_do_app/data/cubit/to_do_state.dart';

class BoardTaskItem extends StatelessWidget {
  final Map model;
  const BoardTaskItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String stringColor = model['color'].split('(0x')[1].split(')')[0];
    int intColor = int.parse(stringColor, radix: 16);
    Color color = Color(intColor);
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<ToDoCubit>(context);

        return Row(
          children: [
            Theme(
              data: ThemeData(
                unselectedWidgetColor: color,
              ),
              child: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: model['status'] == 'completed' ? true : false,
                  checkColor: Colors.white,
                  activeColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onChanged: (value) {
                    if (value! == true) {
                      cubit.updateTaskStatus(
                        model: model,
                        status: model['status'] == 'completed'
                            ? 'uncompleted'
                            : 'completed',
                      );
                    } else {
                      cubit.updateTaskStatus(
                        model: model,
                        status: model['status'] == 'uncompleted'
                            ? 'completed'
                            : 'uncompleted',
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(model['title'],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Spacer(),
            PopupMenuButton(
                onSelected: (value) {
                  if (value == MenuItems.delete) {
                    cubit.deleteFromDataBase(id: model['id']);
                  } else {
                    cubit.updateTaskStatus(
                      model: model,
                      status: value == MenuItems.favorite
                          ? 'favorite'
                          : 'uncompleted',
                    );
                  }
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: MenuItems.favorite,
                        child: Text(
                          'Favorites',
                        ),
                      ),
                      const PopupMenuItem(
                        value: MenuItems.delete,
                        child: Text(
                          'Delete',
                        ),
                      ),
                    ]),
          ],
        );
      },
    );
  }
}

enum MenuItems {
  favorite,
  delete,
}
