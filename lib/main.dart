import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/project_task_provider.dart';
import 'models/time_entry.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TimeEntryProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Time Tracking Home'),
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
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeEntryProvider>(context);
    final entries = provider.entries;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: entries.isEmpty
          ? const Center(child: Text('No time entries yet. Tap + to add one.'))
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return ListTile(
                  title: Text('Task ID: ${entry.taskId}'),
                  subtitle: Text(
                    '${entry.totalTime} hrs on ${entry.date.toLocal().toString().split(' ')[0]}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      provider.deleteTimeEntry(entry.id);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newEntry = TimeEntry(
            id: DateTime.now().toIso8601String(),
            projectId: 'project1',
            taskId: 'task1',
            totalTime: 2.5,
            date: DateTime.now(),
            notes: 'Worked on UI',
          );
          provider.addTimeEntry(newEntry);
        },
        tooltip: 'Add Entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}

