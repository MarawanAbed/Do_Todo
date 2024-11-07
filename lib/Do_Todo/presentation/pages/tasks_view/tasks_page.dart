import 'package:do_todo/Do_Todo/presentation/pages/add_task/add_task_page.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/tasks_view/tasks_body.dart';
import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: const HomeBody(),
        floatingActionButton: CircularMenu(
          alignment: Alignment.bottomLeft,
          startingAngleInRadian: 4.6,
          endingAngleInRadian: 6,
          reverseCurve: Curves.bounceInOut,
          toggleButtonSize: 30,
          items: [
            CircularMenuItem(

                icon: Icons.person,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddTaskPage(
                      isChild: false,
                    );
                  }));
                }),
            CircularMenuItem(
                icon: Icons.child_care,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddTaskPage(
                      isChild: true,
                    );
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
