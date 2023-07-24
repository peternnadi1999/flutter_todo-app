import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Todo/model/Todol.dart';
import 'package:todoapp/Todo/todo_bloc.dart';
import 'package:todoapp/Todo/ui/todo_tile_widget.dart';

class Todo1 extends StatefulWidget {
  const Todo1({super.key});

  @override
  State<Todo1> createState() => _Todo1State();
}

class _Todo1State extends State<Todo1> {
  @override
  void initState() {
    todoBloc.add(InitialEvent());
    super.initState();
  }

  final TodoBloc todoBloc = TodoBloc();
  final _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      bloc: todoBloc,
      listenWhen: (previous, current) => current is TodoActionState,
      buildWhen: (previous, current) => current is! TodoActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case TodoLoadingState:
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case TodoSuccessState:
            final successState = state as TodoSuccessState;
            return Scaffold(
              backgroundColor: Colors.grey.shade200,
              appBar: AppBar(
                title: const Text(
                  'Todo App',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                centerTitle: true,
                backgroundColor: Colors.teal,
              ),
              body: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Column(
                      children: [
                        search(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 0),
                          child: const Text(
                            'All todo',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 58.0),
                            child: ListView.builder(
                              itemCount: successState.todo.length,
                              itemBuilder: (context, index) {
                                return TodoTile(
                                  todo: successState.todo[index],
                                  todoBloc: todoBloc,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            cursorColor: Colors.grey,
                            controller: _todoController,
                            decoration: const InputDecoration(
                              hintText: 'Add a new todo item',
                              border: InputBorder.none,
                            ),
                          ),
                        )),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, right: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (state is TodoSuccessState) {
                                todoBloc
                                    .add(AddTodoEvent(_todoController.text));
                                todoBloc.add(InitialEvent());
                                _todoController.clear();
                              } else {
                                Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
                                minimumSize: Size(60, 60),
                                elevation: 10),
                            child: const Text(
                              '+',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );

          case TodoErrorState:
            return Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );

          default:
            return SizedBox();
        }
      },
    );
  }

  Widget search() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: TextField(
        cursorColor: Colors.grey,
        onChanged: (value) {
          setState(() {});
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 1),
            prefixIcon: const Icon(Icons.search),
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 50, minWidth: 50),
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.grey,
                ))),
      ),
    );
  }
}
