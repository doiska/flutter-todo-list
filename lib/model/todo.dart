class Todo {
  String id;
  String title;
  bool isDone;

  Todo({required this.id, required this.title, this.isDone = false});

  static List<Todo> getList() {
    return [
      Todo(id: '1', title: 'Teste com vários caracteres'),
      Todo(id: '2', title: 'Teste 2', isDone: true),
      Todo(id: '3', title: 'Teste 3'),
      Todo(id: '4', title: 'Teste 4'),
      Todo(id: '5', title: 'Teste 5', isDone: true),
    ];
  }
}
