import 'dart:convert';
import 'package:http/http.dart' as http;

final class Quote {
  final int id;
  final String quote, author;
  Quote({required this.id, required this.quote, required this.author});

  factory Quote.fromJson(json) {
    final obj = Quote(
      id: json["id"],
      quote: json["quote"],
      author: json["author"],
    );
    return obj;
  }

  @override
  String toString() {
    return 'Quote {id: $id, quote: $quote, author: $author}';
  }
}

class QuotesRepository {
  final dummyJson = 'https://dummyjson.com/quotes';
  
  ///Fetch a list of quotes from dummy api
  Future<List<Quote>> fetchQuotes() async {
    final response = await http.get(Uri.parse(dummyJson));
    return (jsonDecode(response.body)['quotes'] as List)
        .map((json) => Quote.fromJson(json))
        .toList();
  }
}
