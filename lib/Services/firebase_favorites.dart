import 'package:blogs_app/Models/quote_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseFavorites extends ChangeNotifier {
  List<Quotes> _favoriteQuotes = List.empty(growable: true);
  List<Quotes> get favoriteQuotes => _favoriteQuotes;

  final firestore = FirebaseFirestore.instance.collection('favorites');

  Future<void> addFavoriteToFirestore(String quote, String author) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    return await firestore.doc(id).set({
      'id': id,
      'quote': quote,
      'author': author,
    });
  }

  Future<void> fetchFavoriteQuotes() async {
    FirebaseFirestore.instance.collection("favorites").snapshots().listen((
      snapshot,
    ) {
      _favoriteQuotes = snapshot.docs.map((doc) {
        final data = doc.data();
        return Quotes(quote: data['quote'], author: data['author']);
      }).toList();
      notifyListeners();
    });
  }

  void deleteFavorite(String author, String quote) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("favorites")
        .where('author', isEqualTo: author)
        .where('quote', isEqualTo: quote)
        .get();

    for (var doc in snapshot.docs) {
      await FirebaseFirestore.instance
          .collection("favorites")
          .doc(doc.id)
          .delete();
    }
    notifyListeners();
  }

  bool isFavorite(String author, String quote) {
    return _favoriteQuotes.any(
      (fav) => fav.author == author && fav.quote == quote,
    );
  }
}
