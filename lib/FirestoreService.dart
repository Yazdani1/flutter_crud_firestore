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
    return _db.collection("notes").snapshots().map((snapshot) =>
        snapshot.documents.map((doc) =>
            Note.fromMap(doc.data, doc.documentID)));
  }


}