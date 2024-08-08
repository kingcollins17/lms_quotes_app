import 'package:get/get.dart';
import 'package:lms_quotes_app/repository/repository.dart';

class QuotesController extends GetxController {
  final QuotesRepository repository;

  final quotes = <Quote>[].obs;
  final isLoading = false.obs;

  bool get hasQuotes => quotes.isNotEmpty;

  QuotesController([QuotesRepository? repository])
      : this.repository = repository ?? QuotesRepository() {
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
}
