import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FirestoreService.dart';
import 'Note.dart';
import 'NoteDetails.dart';
import 'AddData.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        title: Text("Firestore CRUD Application"),
        backgroundColor: Colors.green,
      ),

      body: StreamBuilder(
          stream: FirestoreService().getNotes(),
          builder: (context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator());
            } else {
              return RefreshIndicator(
                onRefresh: getRefresh,
                color: Colors.deepOrange,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Note note = snapshot.data[index];

                      return Card(
                        elevation: 10.0,
                        margin: EdgeInsets.all(10.0),
                        child: Container(
                          height: 100.0,
                          margin: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[

                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(

                                      child: Row(
                                        children: <Widget>[

                                          CircleAvatar(
                                            child: Text(note.title[0]),
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                          ),

                                          SizedBox(width: 6.0,),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  new MaterialPageRoute(
                                                      builder: (_) =>
                                                          NoteDetails(note: note,)));
                                            },
                                            child: Container(
                                              child: Text(note.title,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5.0,),
                                    Container(
                                      child: Text(note.description,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () async {
                                        try {
                                          await FirestoreService().deleteNote(
                                              note.id);
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Icon(Icons.delete,
                                        color: Colors.deepOrange,
                                        size: 30.0,
                                      ),
                                    ),
                                    SizedBox(width: 5.0,),
                                    InkWell(
                                      onTap: () async {
                                        try {
                                          await FirestoreService().deleteNote(
                                              note.id);
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Icon(Icons.edit,
                                        color: Colors.deepOrange,
                                        size: 30.0,
                                      ),
                                    ),

                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      );
                    }
                ),
              );
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,),
        elevation: 20.0,
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (_) => AddNotes()));
        },
      ),
    );
  }
}


