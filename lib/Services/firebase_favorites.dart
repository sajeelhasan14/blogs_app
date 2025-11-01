import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFavorites {
  final firestore = FirebaseFirestore.instance.collection('favorites');

  Future<void> addFavoriteToFirestore(String quote,String author){
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    return firestore.doc(id).set({
      'quote': quote,
      'author': author,
    });
  }

}
