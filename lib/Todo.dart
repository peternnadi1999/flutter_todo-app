import 'package:flutter/material.dart';

import 'package:todoapp/model/Todol.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  // final todolist = ToDo.todoList();

  // List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  final CollectionReference _todo =
      FirebaseFirestore.instance.collection("Todo");
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 58.0),
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(13),
                          child: const Text(
                            'All todo',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        StreamBuilder(
                            stream: (name != "" && name != null)
                                ? _todo
                                    .where("todoText", isEqualTo: name)
                                    .snapshots()
                                : _todo.snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          snapshot.data!.docs[index];
                                      return Card(
                                          margin: EdgeInsets.all(10),
                                          child: ListTile(
                                            onTap: () {
                                              _todo
                                                  .doc(documentSnapshot!.id)
                                                  .update({
                                                "isDone":
                                                    !documentSnapshot["isDone"]
                                              });
                                            },
                                            tileColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 20),
                                            leading: Icon(
                                              documentSnapshot["isDone"]
                                                  ? Icons
                                                      .check_box_outline_blank
                                                  : Icons.check_box,
                                              color: Colors.teal,
                                            ),
                                            title: Text(
                                              documentSnapshot["todoText"],
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      documentSnapshot["isDone"]
                                                          ? TextDecoration.none
                                                          : TextDecoration
                                                              .lineThrough,
                                                  fontSize: 16),
                                            ),
                                            trailing: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: IconButton(
                                                iconSize: 18,
                                                color: Colors.white,
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  _todo
                                                      .doc(documentSnapshot.id)
                                                      .delete();
                                                },
                                              ),
                                            ),
                                          ));
                                    });
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })
                      ],
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
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
                      _addTodoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        minimumSize: Size(60, 60),
                        elevation: 10),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _addTodoItem(String todo) {
    setState(() {
      if (_todoController.text.isEmpty) {
        return;
      } else {
        _todo
            .add(ToDo(todoText: todo).toJson())
            .whenComplete(() => const SnackBar(
                  backgroundColor: Colors.green,
                  width: 200,
                  content: Text(
                    'Sucessfully added',
                    style: TextStyle(color: Colors.white),
                  ),
                ));

        // todolist.add(ToDo(
        //     id: DateTime.now().millisecondsSinceEpoch.toString(),
        //     todoText: toDo));
      }
    });
    _todoController.clear();
  }

  Widget search() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: TextField(
        cursorColor: Colors.grey,
        onChanged: (value) {
          setState(() {
            name = value;
          });
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
