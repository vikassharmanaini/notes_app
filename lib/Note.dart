import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'NotesModal.dart';

class Note extends StatefulWidget {
  Note({super.key, required this.notes});
  Notes notes;
  @override
  State<Note> createState() => _NoteState(notes);
}

class _NoteState extends State<Note> {
  _NoteState(this._notes);
  final Notes _notes;
  late TextEditingController title;
  late TextEditingController note;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = TextEditingController();
    note = TextEditingController();
    title.text = _notes.title.toString();
    note.text = _notes.body.toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    title.dispose();
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          bool res = await setData(s: false);
          if (res) {
            return true;
          } else {
            return false;
          }
        },
        child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: setData, icon: const Icon(Icons.arrow_back)),
                    IconButton(onPressed: deleteThis, icon: Icon(Icons.delete))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: title,
                    decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromARGB(19, 158, 158, 158)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: new Scrollbar(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: new TextField(
                          controller: note,
                          maxLines: 100,
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Example : I Love Java',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
        ));
  }

  Future setData({bool s = false}) async {
    print('exicuting');
    if (title.text != '' || note.text != '') {
      print('exicuting');
      var box = await Hive.openBox('note');
      if (box.isOpen) {
        print('exicuting');
        box.put(
            _notes.id.toString(),
            Notes(
                id: _notes.id.toString(),
                title: title.text,
                body: note.text,
                time: DateTime.now().toString()));
        if (!s) {
          Navigator.of(context).pop(true);
        }
        ;
        return true;
      }
    } else {
      if (!s) {
        Navigator.of(context).pop(true);
      }
      return true;
    }
  }

  Future deleteThis() async {
    var box = await Hive.openBox('note');
    if (box.isOpen) {
      print(box.keys.toString());
      print(_notes.id.toString());
      box.delete(_notes.id.toString());
      Navigator.of(context).pop(true);
    }
  }
}
