import 'package:flutter/material.dart';
import 'FirestoreService.dart';
import 'Note.dart';
import 'Home.dart';

class AddNotes extends StatefulWidget {
  @override
  _AddNotesState createState() => new _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  GlobalKey<FormState>_key = GlobalKey<FormState>();

  TextEditingController _titlecontroller;
  TextEditingController _descriptioncontroller;


  @override
  void initState() {
    super.initState();
    _titlecontroller = TextEditingController(text: '');
    _descriptioncontroller = TextEditingController(text: '');
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        title: Text("Add you noe"),
        backgroundColor: Colors.purple,
      ),

      body: Container(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[

                TextFormField(
                  controller: _titlecontroller,
                  decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 10.0,),

                TextFormField(
                  controller: _descriptioncontroller,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30.0,),

                ButtonTheme(
                  height: 50.0,
                  splashColor: Colors.green,
                  minWidth: MediaQuery
                      .of(context)
                      .size
                      .width / 1,
                  child: RaisedButton(
                    child: Text("SAVE",
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white
                      ),
                    ),
                    color: Colors.amber,
                    padding: EdgeInsets.all(10.0),
                    onPressed: () async {
                      try {
                        await FirestoreService().addNote(
                            Note(title: _titlecontroller.text,
                                description: _descriptioncontroller.text
                            )
                        );
                        Navigator.of(context).push(
                            new MaterialPageRoute(builder: (_) =>Home()));
                      } catch (e) {
                        print(e);
                      }
                    },
                    shape: StadiumBorder(),
                  ),
                )


              ],
            ),
          ),
        ),
      ),

    );
  }
}


