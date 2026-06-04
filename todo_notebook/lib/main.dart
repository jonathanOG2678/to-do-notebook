import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do Notebook',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'To-Do Notebook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> dayTermTasks = [];
  final List<String> longTermTasks = [];

  
  void addTask() {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Day Term'),
                Tab(text: 'Long Term'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column( //Widgets for Today Page
                children: [
                  FloatingActionButton(
                    onPressed: () {},
                    tooltip: 'Add a task for today',
                    child: Icon(Icons.add),
                  )
                ],
              ),
              Column( //Widgets for Long Term Page
                children: [
                  FloatingActionButton(
                    onPressed: () {},
                    tooltip: 'Add a task for today',
                    child: Icon(Icons.add),
                  )
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}