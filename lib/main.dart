import 'package:flutter/material.dart';
import 'package:sticky_notes/page/note_edit_page.dart';
import 'package:sticky_notes/page/note_list_page.dart';
import 'package:sticky_notes/page/note_view_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primarySwatch: Colors.teal,
        //useMaterial3: true,
      ),
      //home: NoteListPage(),
      initialRoute: NoteListPage.routeName,
      routes: {
        NoteListPage.routeName: (context) => NoteListPage(),
        NoteEditPage.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          final index = args != null ? args as int : null;
          return NoteEditPage(index);
          },
        NoteViewPage.routeName: (context) {
          final index = ModalRoute.of(context)!.settings.arguments as int;
          return NoteViewPage(index);
        },
      },
    );
  }
}