import 'package:cloud_firestore/cloud_firestore.dart';
import 'Note.dart';

class FirestoreService {

  static final FirestoreService _firestoreService = FirestoreService
      ._internal();

  FirestoreService._internal();

  Firestore _db = Firestore.instance;

  factory FirestoreService(){
    return _firestoreService;
  }

  Stream<List<Note>> getNotes() {
    return _db.collection("note").orderBy("title", descending: true).snapshots().map((snapshot) =>
        snapshot.documents.map((doc) =>
            Note.fromMap(doc.data, doc.documentID)).toList(),
    );
  }

  //add note

  Future<void> addNote(Note note){
    return _db.collection("note").add(note.toMap());
  }

  //delete note

  Future<void> deleteNote(String id){
    return _db.collection("note").document(id).delete();
  }

  //update data

  Future<void>updateNote(Note note){
    return _db.collection("note").document(note.id).updateData(note.toMap());
  }

}