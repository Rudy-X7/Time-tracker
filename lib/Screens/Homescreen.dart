import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/time_tracker_provider.dart';
import '../models/time_entry.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Time Tracking'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'All Entries'),
              Tab(icon: Icon(Icons.folder), text: 'By Project'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllEntriesTab(),
            GroupedByProjectTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final provider = Provider.of<TimeEntryProvider>(context, listen: false);
            final newEntry = TimeEntry(
              id: DateTime.now().toIso8601String(),
              projectId: 'project1',
              taskId: 'task1',
              totalTime: 1.0,
              date: DateTime.now(),
              notes: 'Worked on API integration',
            );
            provider.addTimeEntry(newEntry);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
