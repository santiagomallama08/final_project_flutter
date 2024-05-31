import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getAllCollection({required String nameCollection}) async {
  try {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db.collection(nameCollection).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  } catch (e) {
    print('Error getting documents from $nameCollection: $e');
    throw e;
  }
}

Future<void> addDocumentToCollection(String collectionName, Map<String, dynamic> data) async {
  try {
    await _db.collection(collectionName).add(data);
    print('Document added to $collectionName');
  } catch (e) {
    print('Error adding document to $collectionName: $e');
    throw e;
  }
}
