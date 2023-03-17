import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/Note.dart';
import 'package:notes_app/NotesModal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Notes>? response;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Note(
                        notes: Notes(
                            id: DateTime.now().toString(),
                            time: '',
                            title: '',
                            body: ''),
                      ))),
          icon: Icon(Icons.add),
          label: Text(
            'Add New',
            style: TextStyle(fontSize: 16),
          )),
      body: (response == null)
          ? CircularProgressIndicator()
          : (response!.isEmpty)
              ? Center(
                  child: Text('Create Your First Note'),
                )
              : ListView.builder(
                  itemCount: response!.length,
                  itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2, blurStyle: BlurStyle.outer)
                            ]),
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Note(
                                        notes: response![index],
                                      ))),
                          isThreeLine: true,
                          title: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                response![index].title.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          subtitle: Text(
                            response![index].body.toString(),
                            softWrap: false,
                            maxLines: 8,
                          ),
                        ),
                      )),
    );
  }

  Future getdata() async {
    var box = await Hive.openBox('note');
    if (box.isOpen) {
      print('after open');
      setState(() {
        if (box.isNotEmpty) {
          print(box.keys);
          response = box.values.cast<Notes>().toList();
        } else {
          response = [];
        }
      });
    }
  }
}
