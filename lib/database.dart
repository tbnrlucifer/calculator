import 'package:calculator/calculation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference calcCollection =
      FirebaseFirestore.instance.collection('calculations');

  Future updateUserData(String calculation, String name) async {
    return await calcCollection.doc(uid).set({
      'calculation': calculation,
      'name': name,
    });
  }

// calculation list from snapshot
  List<Calculation> _calcListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Calculation(
          name: doc.get('name') ?? '',
          calculation: doc.get('calculation') ?? '');
    }).toList();
  }

// get calculations stream
  Stream<List<Calculation>> get calculations {
    return calcCollection.snapshots().map(_calcListFromSnapshot);
  }
}
