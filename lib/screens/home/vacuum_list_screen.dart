import 'package:flutter/material.dart';

class VacuumListScreen extends StatefulWidget {
  const VacuumListScreen({super.key});

  @override
  State<VacuumListScreen> createState() => _VacuumListScreenState();
}

class _VacuumListScreenState extends State<VacuumListScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2);
  }
}
