import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SearchRobot {
  final WidgetTester tester;
  SearchRobot(this.tester);

  Future<void> enterMovieQuery(String query) async {
    final textFieldFinder = find.byKey(const Key('enterMovieQuery'));

    await tester.ensureVisible(textFieldFinder);
    await tester.enterText(textFieldFinder, query);

    await Future.delayed(const Duration(seconds: 3));

    await tester.pumpAndSettle();
  }

  Future<void> enterTvQuery(String query) async {
    final textFieldFinder = find.byKey(const Key('enterTvQuery'));

    await tester.ensureVisible(textFieldFinder);
    await tester.enterText(textFieldFinder, query);

    await Future.delayed(const Duration(seconds: 3));

    await tester.pumpAndSettle();
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
