import 'package:get/get.dart';
import 'package:lms_quotes_app/repository/repository.dart';

class QuotesController extends GetxController {
  final QuotesRepository repository;

  final quotes = <Quote>[].obs;
  final isLoading = false.obs;

  final searchResults = <Quote>[].obs;

  bool get hasQuotes => quotes.isNotEmpty;

  bool get hasSearchResults => searchResults.isNotEmpty;

  QuotesController([QuotesRepository? repository])
      : repository = repository ?? QuotesRepository() {
    getQuotes();
  }

  Future<void> getQuotes() async {
    try {
      isLoading.value = true;
      final result = await repository.fetchQuotes();
      quotes.assignAll(result);
    } catch (e) {
      Get.snackbar('Something went wrong', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> search(String query) async {
    isLoading.value = true;
    update();
    await Future.delayed(const Duration(seconds: 2)); // simulate search
    searchResults.assignAll(
      quotes.where(
        (arg) =>
            arg.quote.toLowerCase().contains(query.toLowerCase()) ||
            arg.author.toLowerCase().contains(query.toLowerCase()),
      ),
    );
    isLoading.value = false;
    update();
  }
}
