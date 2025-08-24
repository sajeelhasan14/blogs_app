import 'dart:convert';
import 'package:blogs_app/Models/quote_model.dart';
import 'package:blogs_app/Services/api_service.dart';
import 'package:http/http.dart' as http;

class QuotesService {
  Future<QuoteModel> getQuotes() async {
    final url = Uri.parse(ApiService.quote);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return QuoteModel.fromJson(responseBody);
    } else {
      throw Exception("Ooops! Something went Wrong");
    }
  }
}
