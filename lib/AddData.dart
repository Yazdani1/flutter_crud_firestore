import 'package:flutter/material.dart';
import 'FirestoreService.dart';
import 'Note.dart';
import 'Home.dart';

class AddNotes extends StatefulWidget {

  final Note note;

  const AddNotes({Key key, this.note}) : super(key: key);

  @override
  _AddNotesState createState() => new _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  GlobalKey<FormState>_key = GlobalKey<FormState>();

  TextEditingController _titlecontroller;
  TextEditingController _descriptioncontroller;
  FocusNode _descriptionNote;


  @override
  void initState() {
    super.initState();
    _titlecontroller = TextEditingController(
        text: widget.note.title != null ? widget.note.title : '');
    _descriptioncontroller =
        TextEditingController(text: widget.note.description != null
            ? widget.note.description
            : '');
    _descriptionNote = FocusNode();
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
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_descriptionNote);
                  },
                  controller: _titlecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title can not be empty";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 10.0,),

                TextFormField(
                  focusNode: _descriptionNote,
                  controller: _descriptioncontroller,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description can not be empty";
                    }
                  },
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
                      if (_key.currentState.validate()) {
                        try {
                          await FirestoreService().addNote(
                              Note(title: _titlecontroller.text,
                                  description: _descriptioncontroller.text
                              )
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                              new MaterialPageRoute(builder: (_) => Home()));
                        } catch (e) {
                          print(e);
                        }
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


