import 'package:flutter/material.dart';
import 'package:todo_list/constants/color.dart';
import 'package:todo_list/model/todo.dart';

import '../widgets/todo_item.dart';

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  final todoList = Todo.getList();

  String _searchText = "";

  final _insertController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  searchBox(),
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 20),
                    child: const Text("Today",
                        style: TextStyle(color: primaryTextColor, fontSize: 30)),
                  ),
                  buildTodoList()
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 0),
                  decoration: const BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: secondaryColor,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0),
                      ]),
                  child: buildInputField(),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded buildTodoList() {
    List<Todo> filteredTodos = _searchText.isNotEmpty
        ? todoList
            .where((todo) => todo.title.toLowerCase().contains(_searchText.toLowerCase()))
            .toList()
        : todoList;

    return Expanded(
        child: ListView.builder(
      padding: const EdgeInsets.only(top: 0, bottom: 50),
      itemCount: filteredTodos.length,
      itemBuilder: (BuildContext context, int index) {
        return TodoItem(
          todo: filteredTodos[index],
          onTodoChanged: handleTodoChange,
          onDeleteItem: handleDeleteItem,
        );
      },
    ));
  }

  TextField buildInputField() {
    return TextField(
      controller: _insertController,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(color: primaryTextColor),
      decoration: InputDecoration(
        suffixIcon: MaterialButton(
          minWidth: 0,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: primaryTextColor),
          onPressed: () => _addTodoItem(_insertController.text),
        ),
        hintText: "What do you want to do?",
        hintStyle: const TextStyle(color: secondaryTextColor),
        border: InputBorder.none,
      ),
    );
  }

  Container searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        style: const TextStyle(color: primaryTextColor, decorationStyle: TextDecorationStyle.solid),
        decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: primaryTextColor, size: 20),
            hintText: "Search",
            hintStyle: TextStyle(color: secondaryTextColor, fontSize: 15)),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: secondaryColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu, color: primaryButtonColor, size: 30),
          ],
        ));
  }

  void _runFilter(String enteredKeyword) {
    setState(() {
      _searchText = enteredKeyword;
    });
  }

  void _addTodoItem(String title) {
    if (title.isEmpty) return;

    setState(() {
      todoList.add(Todo(
        id: DateTime.now().toString(),
        title: title,
        isDone: false,
      ));
    });

    _insertController.clear();
    FocusScope.of(context).unfocus();
  }

  void handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void handleDeleteItem(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }
}
