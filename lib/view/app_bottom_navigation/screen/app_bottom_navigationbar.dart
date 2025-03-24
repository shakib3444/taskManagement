import 'package:flutter/material.dart';
import 'package:taskmanagement/view/canceled_screen/screen/canceled_screen.dart';
import 'package:taskmanagement/view/complete_screen/screen/complete_screen.dart';
import 'package:taskmanagement/view/new_screen/screen/new_screen.dart';
import 'package:taskmanagement/view/progress_screen/screen/progress_screen.dart';

import '../../widgets/tm_appbar_widget.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int selectedIndex =0;
  final List<Widget> pages =[
    NewScreen(),
    ProgressScreen(),
    CompleteScreen(),
    CanceledScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),

      body: pages[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
          onDestinationSelected: (index){
          setState(()=>selectedIndex = index);
          },
          destinations:[
            NavigationDestination(
                icon: Icon(Icons.new_label_outlined),
                label: "New",
            ),
            NavigationDestination(
                icon: Icon(Icons.trending_up_outlined),
                label: "Progress",
            ),
            NavigationDestination(
                icon: Icon(Icons.done),
                label: "Complete",
            ),
            NavigationDestination(
                icon: Icon(Icons.cancel_presentation),
                label: "Canceled",
            ),
          ]
      ),

    );
  }
}


