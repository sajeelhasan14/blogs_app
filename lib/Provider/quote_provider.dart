import 'package:blogs_app/Models/quote_model.dart';
import 'package:blogs_app/Services/quotes_service.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
    if (_quotes.isNotEmpty) return;
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

  // 🎨 Your Figma colors
  final List<Color> codeColors = [
    Color(0xFFC084FC), // Purple
    Color(0xFF60A5FA), // Blue
    Color(0xFF4ADE80), // Green
    Color(0xFFFACC15), // Yellow
    Color(0xFFF472B6), // Pink
  ];

  // Store colors for each quote (so they don't change every rebuild)
  final Map<int, Color> _quoteColors = {};
  Color? _lastColor; // store last assigned color

  Color getColorForQuote(int index) {
    if (_quoteColors.containsKey(index)) {
      return _quoteColors[index]!;
    }

    Color newColor;
    do {
      newColor = codeColors[Random().nextInt(codeColors.length)];
    } while (newColor == _lastColor && codeColors.length > 1);

    _lastColor = newColor; // remember last color
    _quoteColors[index] = newColor; // assign color to this quote

    return newColor;
  }

  // Searching Logic:

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  bool _isSearching = false;
  bool get isSearching => _isSearching;

  void updateSearchQuery(String input) {
    _searchQuery = input;
    notifyListeners();
  }

  List<Quotes> get searchQuotes {
    if (_searchQuery.isEmpty) return _quotes;
    return _quotes.where((qoute) {
      return qoute.quote!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          qoute.author!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void toggleSearching() {
    _isSearching = !_isSearching;
    notifyListeners();
  }
}
