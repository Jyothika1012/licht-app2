import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Menubar extends StatefulWidget {
  const Menubar({super.key});

  @override
  State<Menubar> createState() => _MenubarState();
}

class _MenubarState extends State<Menubar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.blueGrey),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.assignment),
                        title: Text("Quiz results"),
                      )
                    ],
                  )),
            ],
          ),
        ));
  }
}
