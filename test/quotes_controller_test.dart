import 'package:lms_quotes_app/controllers/controller.dart';
import 'package:lms_quotes_app/repository/quotes_repository.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<QuotesRepository>()])
import 'quotes_controller_test.mocks.dart';

void main() {
  late QuotesRepository repository;
  late QuotesController controller;

  setUp(() {
    repository = MockQuotesRepository();
    controller = QuotesController(repository);
  });
  
  final mockQuotes = [
    Quote(id: 1, quote: 'To be wealthy is to be wise', author: 'Joseph'),
    Quote(id: 2, quote: 'Make haste while the sun shines', author: 'Martha'),
    Quote(id: 3, quote: 'Always turn the left cheek', author: 'Jesus'),
    Quote(id: 4, quote: 'Never give all your money as offering', author: 'Lucy'),
  ];

  group('Test QuotesController', () {

    test('getQuotes', () async {

    //mock behaviour
    when(repository.fetchQuotes()).thenAnswer((_) async => mockQuotes);
      expect(controller.quotes, isEmpty);

      await controller.getQuotes();

      //print(controller.quotes);
      expect(controller.quotes, isNotEmpty);
    });

    test('search(String query)', () async {

    //mock behaviour
    when(repository.fetchQuotes()).thenAnswer((_) async => mockQuotes);
      expect(controller.quotes, isEmpty); //expect initally no quotes
      await controller.getQuotes();
      expect(controller.quotes, isNotEmpty); //expect that quotes have been fetched

      expect(controller.searchResults, isEmpty); //expect searchResults is empty
      await controller.search('Lucy'); //search by author

      expect(controller.searchResults, isNotEmpty); //after searching expect result is not empty
    });
  });
}
