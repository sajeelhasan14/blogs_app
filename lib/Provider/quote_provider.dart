import 'package:blogs_app/Models/quote_model.dart';
import 'package:blogs_app/Services/quotes_service.dart';
import 'package:flutter/material.dart';

class QuoteProvider extends ChangeNotifier {
  final QuotesService _quotesService = QuotesService();

  List<Quotes> _quotes = List.empty(growable: true);
  List<Quotes> get quotes => _quotes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  final List<Quotes> _favorites = List.empty(growable: true);
  List<Quotes> get favorites => _favorites;

  Future<void> fetchQuotes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await _quotesService.getQuotes();
      _quotes = response.quotes ?? [];
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  void addFavorite(Quotes quote) {
    _favorites.add(quote);
  }
}
