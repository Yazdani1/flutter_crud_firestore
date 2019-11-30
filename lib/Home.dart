import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FirestoreService.dart';
import 'Note.dart';
import 'NoteDetails.dart';


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
        backgroundColor: Colors.amber,
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
                        child: Container(
                          height: 120.0,
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (_) => NoteDetails(note: note,)));
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
                              SizedBox(height: 5.0,),
                              Container(
                                child: Text(note.description,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Colors.black
                                  ),
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


    );
  }
}


