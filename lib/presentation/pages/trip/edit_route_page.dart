import 'package:flutter/material.dart';

class EditRoutePage extends StatefulWidget{
  const EditRoutePage({super.key});

  @override
  State<EditRoutePage> createState() => _EditRoutePageState();
}

class _EditRoutePageState extends State<EditRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Route'),
      ),
      body: Center(
        child: Text('Edit Route Page Content Goes Here'),
      ),
    );
  }
}