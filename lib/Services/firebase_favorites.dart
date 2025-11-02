import 'package:blogs_app/Models/quote_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseFavorites extends ChangeNotifier {
List<Quotes> _favoriteQuotes = List.empty(growable: true);
List<Quotes> get favoriteQuotes => _favoriteQuotes;

  final firestore = FirebaseFirestore.instance.collection('favorites');

  Future<void> addFavoriteToFirestore(String quote, String author) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    return firestore.doc(id).set({'id': id, 'quote': quote, 'author': author});
  }

  Future<void> fetchFavoriteQuotes() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("favorites")
        .get();
    final favoriteQuotes = snapshot.docs.map((doc) {
      final data = doc.data();
      return Quotes(quote: data["quote"], author: data["author"]);
    }).toList();
    _favoriteQuotes = [...favoriteQuotes];
    notifyListeners();
  }
}
