import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/time_entry.dart';

class TimeEntryProvider with ChangeNotifier {
  List<TimeEntry> _entries = [];

  List<TimeEntry> get entries => _entries;

  static const _storageKey = 'time_entries';

  TimeEntryProvider() {
    loadEntries();
  }

  Future<void> addTimeEntry(TimeEntry entry) async {
    _entries.add(entry);
    notifyListeners();
    await saveEntries();
  }

  Future<void> deleteTimeEntry(String id) async {
    _entries.removeWhere((entry) => entry.id == id);
    notifyListeners();
    await saveEntries();
  }

  Future<void> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);

    if (data != null) {
      final List decodedList = json.decode(data);
      _entries = decodedList
          .map((item) => TimeEntry.fromJson(item as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  Future<void> saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_entries.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }
}
