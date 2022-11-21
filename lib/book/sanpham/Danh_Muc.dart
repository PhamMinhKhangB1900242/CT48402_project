import 'package:flutter/material.dart';

class ListTileSelectExample extends StatefulWidget {
  static const routeName = '/danhmuc';
  const ListTileSelectExample({super.key});

  @override
  ListTileSelectExampleState createState() => ListTileSelectExampleState();
}

class ListTileSelectExampleState extends State<ListTileSelectExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh Mục',
        ),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: const [
              ListTile(
                leading: Icon(Icons.history_edu_rounded),
                title: Text('Lịch Sử'),
              ),
              ListTile(
                leading: Icon(Icons.gamepad),
                title: Text('Giải Trí'),
              ),
              ListTile(
                leading: Icon(Icons.psychology),
                title: Text('Tâm lý'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
