import 'package:flutter/widgets.dart';
import 'package:todo_game/bloc/app_bloc.dart';
import 'package:todo_game/pages/login_page.dart';
import 'package:todo_game/pages/home_page.dart';
import 'package:todo_game/pages/profile_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
