import 'package:flutter/material.dart';

import '../data/note.dart';
import '../providers.dart';

class NoteEditPage extends StatefulWidget {

  static const routeName = '/edit';

  final int? index;
  NoteEditPage(this.index);

  @override
  State createState() => _NoteEditPageState();

}

class _NoteEditPageState extends State<NoteEditPage> {

  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  Color color = Note.colorDefault;

  @override
  void initState() {
    super.initState();
    final noteIndex = widget.index;
    if (noteIndex != null) {
      final note = noteManager().getNote(noteIndex);
      titleController.text = note.title;
      bodyController.text = note.body;
      color = note.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('노트 편집'),
        actions: [
          IconButton(
            onPressed: _displayColorSelectionDialog,
            icon: Icon(Icons.color_lens),
            tooltip: '배경색 선택',
          ),
          IconButton(
            onPressed: _saveNote,
            icon:Icon(Icons.save),
            tooltip: '저장',
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: color,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '제목 입력',
                  ),
                  maxLines: 1,
                  style: TextStyle(fontSize: 20.0),
                  controller: titleController,
                ),
                SizedBox(height: 8.0),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '노트 입력'
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: bodyController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _displayColorSelectionDialog() {
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('배경색 선택'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('없음'),
              onTap: () => _applyColor(Note.colorDefault),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Note.colorRed),
              title: Text('빨간색'),
              onTap: () => _applyColor(Note.colorRed),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Note.colorOrange),
              title: Text('오렌지색'),
              onTap: () => _applyColor(Note.colorRed),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Note.colorYellow),
              title: Text('노란색'),
              onTap: () => _applyColor(Note.colorRed),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Note.colorLime),
              title: Text('연두색'),
              onTap: () => _applyColor(Note.colorRed),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Note.colorBlue),
              title: Text('파란색'),
              onTap: () => _applyColor(Note.colorRed),
            ),
          ],
        ),
      );
    },);
  }

  void _applyColor(Color newColor) {
    setState(() {
      Navigator.pop(context);
      color = newColor;
    });
  }

  void _saveNote() {
    if (bodyController.text.isNotEmpty) {

      final note = Note(
        bodyController.text,
        title: titleController.text,
        color: color,
      );

      final noteIndex = widget.index;

      if (noteIndex != null) {
        noteManager().updateNote(noteIndex, note);
      } else {
        noteManager().addNote(note);
      }

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('노트를 입력하세요.'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

}

