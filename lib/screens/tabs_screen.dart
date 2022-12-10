import 'package:flutter/material.dart';
import 'package:flutter_bloc_tasks_app/screens/add_task_screen.dart';
import 'package:flutter_bloc_tasks_app/screens/completed_tasks_screen.dart';
import 'package:flutter_bloc_tasks_app/screens/favorite_tasks_screen.dart';
import 'package:flutter_bloc_tasks_app/screens/my_drawer.dart';
import 'package:flutter_bloc_tasks_app/screens/pending_screen.dart';
import 'package:flutter_bloc_tasks_app/services/CustomSearchDelegate.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  static const id = 'tabs screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final List<Widget> _pageDetail = [
    const PendingTasksScreen(),
    const CompletedTasksScreen(),
    const FavoriteTasksScreen(),
  ];
  final List<String> _pageTitle = [
    'Pending Tasks',
    'Completed Tasks',
    'Favorite Tasks',
  ];
  var _selectedPageIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _pageDetail.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedPageIndex = _controller.index;
      });
    });
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
          child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddTaskScreen(),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle[_controller.index]),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          ),
        ],
        bottom: TabBar(
          tabs: const [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.done)),
            Tab(icon: Icon(Icons.favorite)),
          ],
          unselectedLabelColor: Colors.white.withOpacity(0.25),
          labelColor: Colors.white,
          controller: _controller,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Expanded(
              child: TabBarView(
            controller: _controller,
            children: _pageDetail,
          )),
        ],
      ),
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
