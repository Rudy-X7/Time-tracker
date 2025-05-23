import 'package:flutter/foundation.dart';

class TimeEntry {
  final String taskName;
  final DateTime startTime;
  DateTime? endTime;

  TimeEntry({
    required this.taskName,
    required this.startTime,
    this.endTime,
  });

  Duration get duration => endTime != null ? endTime!.difference(startTime) : Duration.zero;
}

class TimeTrackerProvider extends ChangeNotifier {
  List<TimeEntry> _entries = [];
  TimeEntry? _currentEntry;

  List<TimeEntry> get entries => _entries;
  TimeEntry? get currentEntry => _currentEntry;
  bool get isTracking => _currentEntry != null;

  void startTracking(String taskName) {
    if (_currentEntry != null) return;
    _currentEntry = TimeEntry(taskName: taskName, startTime: DateTime.now());
    notifyListeners();
  }

  void stopTracking() {
    if (_currentEntry == null) return;
    _currentEntry!.endTime = DateTime.now();
    _entries.add(_currentEntry!);
    _currentEntry = null;
    notifyListeners();
  }

  void reset() {
    _currentEntry = null;
    _entries.clear();
    notifyListeners();
  }

  Duration get totalTrackedTime {
    return _entries.fold(Duration.zero, (sum, entry) => sum + entry.duration);
  }
}
