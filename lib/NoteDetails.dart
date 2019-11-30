import 'package:flutter/material.dart';
import 'Note.dart';

class NoteDetails extends StatefulWidget {

  final Note note;

  //NoteDetails(this.note);

  const NoteDetails({Key key, this.note}) : super(key: key);

  //NoteDetails({Key key, this.note}):super(key:key);

  @override
  _NoteDetailsState createState() => new _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        title: Text("Note Details"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(

        child: Card(
          margin: EdgeInsets.all(10.0),
          elevation: 15.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[

                Container(
                  child: Text(widget.note.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                  ),
                  ),
                ),
                SizedBox(height: 5.0,),

                Container(
                  child: Text(widget.note.description,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),

      ),

    );
  }
}


