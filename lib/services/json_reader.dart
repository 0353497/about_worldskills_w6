import 'dart:convert';

import 'package:flutter/services.dart';

class JsonReader {
  static Future<List> readStatistics() async {
    final json = await rootBundle.loadString("assets/data/statistic.json");
    return await jsonDecode(json);
  }

  static Future<List> readSkills() async {
    final json = await rootBundle.loadString("assets/data/skills.json");
    return await jsonDecode(json);
  }
}
