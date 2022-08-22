import 'package:flutter/widgets.dart';
import 'package:todo_game/bloc/app_bloc.dart';
import 'package:todo_game/pages/login_page.dart';
import 'package:todo_game/pages/register_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [RegisterPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
