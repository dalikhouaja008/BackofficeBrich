import 'package:brichbackoffice/data/entities/PredictionData.dart';
import 'package:brichbackoffice/data/repositories/CurrencyConverterRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Pour utiliser Future et async/await
import 'package:intl/intl.dart';

class CurrencyConverterController extends GetxController {
  final CurrencyConverterRepository repository;

  CurrencyConverterController(this.repository);

  // Observable variables
  final RxString fromCurrency = 'TND'.obs;
  final RxString toCurrency = 'EUR'.obs;
  final RxDouble convertedAmount = 0.0.obs;
  final RxBool isLoading = false.obs;
  final RxList<Map<String, dynamic>> exchangeRates =
      <Map<String, dynamic>>[].obs;
  final TextEditingController amountController = TextEditingController();
  final RxString conversionResultText = ''.obs;

  // List of supported currencies
  final List<String> currencies = ['USD', 'EUR', 'TND', 'GBP', 'JPY'];

  final RxMap<String, List<PredictionData>> predictions =
      <String, List<PredictionData>>{}.obs;
  final RxBool isLoadingPredictions = false.obs;
   final RxString currencyPrediction = 'EUR'.obs;
  @override
  void onInit() {
    super.onInit();
    fetchExchangeRates();
    loadPredictions(getCurrentDate(), ['EUR']);
  }

 Future<void> loadPredictions(String date, List<String> currencies) async {
  try {
    isLoadingPredictions.value = true;

    final response = await repository.getCurrencyPredictions(
      date: date, 
      currencies: currencies
    );

    // Modify the condition to explicitly handle 200 and 201
    if (response.statusCode == 200 || response.statusCode == 201) {
      final newPredictions = response.data?.predictions ?? {};
      predictions.value = newPredictions;
      
      if (kDebugMode) {
        print('Successful Predictions:');
        newPredictions.forEach((currency, currencyPredictions) {
          print('$currency: ${currencyPredictions.map((pred) => 
            '{date: ${pred.date}, value: ${pred.value}}'
          ).toList()}');
        });
      }
      
      // Remove the error snackbar when predictions are successfully loaded
    } else {
      if (kDebugMode) {
        print('Error Response: ${response.statusCode}');
      }
      predictions.value = {};
      Get.snackbar(
        'Error', 
        'Failed to load predictions',
        snackPosition: SnackPosition.BOTTOM
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print('Exception in loadPredictions: $e');
    }
    predictions.value = {};
    Get.snackbar(
      'Error', 
      'An error occurred while loading predictions',
      snackPosition: SnackPosition.BOTTOM
    );
  } finally {
    isLoadingPredictions.value = false;
  }
}

  // Helper method to get current date in the same format as Kotlin version
  String getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  // Method to switch currencies
  void switchCurrencies() {
    final temp = fromCurrency.value;
    fromCurrency.value = toCurrency.value;
    toCurrency.value = temp;
  }

  // Fetch exchange rates
  Future<void> fetchExchangeRates() async {
    try {
      isLoading.value = true;
      final response = await repository.fetchExchangeRates();

      if (response.statusCode == 200) {
        // Assuming the response is a list of exchange rate objects
        exchangeRates.value = List<Map<String, dynamic>>.from(response.data);
      } else {
        Get.snackbar('Erreur', 'Impossible de récupérer les taux de change');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la récupération des taux: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to perform currency conversion
  Future<void> convertCurrency() async {
    try {
      if (amountController.text.isEmpty) {
        conversionResultText.value = 'Veuillez saisir un montant';
        return;
      }

      isLoading.value = true;
      final amount = amountController.text;
      double rate = 0.0;

      try {
        if (fromCurrency.value == 'TND') {
          rate = await repository.getBuyingRate(fromCurrency.value, amount);
        } else if (toCurrency.value == 'TND') {
           rate = await repository.getSellingRate(toCurrency.value, amount);
        } else {
          rate = await repository.getSellingRate(toCurrency.value, amount);
        }
      } catch (rateError) {
        print('Erreur de récupération du taux : $rateError');
        conversionResultText.value =
            'Impossible de récupérer le taux de change';
        return;
      }

      if (rate == 0.0) {
        conversionResultText.value = 'Taux de change invalide';
        return;
      }

      convertedAmount.value = double.parse(amount) * rate;
      conversionResultText.value =
          '${amount} ${fromCurrency.value} = ${convertedAmount.value.toStringAsFixed(2)} ${toCurrency.value}';
    } catch (e) {
      print('Erreur globale : $e');
      conversionResultText.value = 'Échec de la conversion: $e';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Dispose of the controller when no longer needed
    amountController.dispose();
    super.onClose();
  }
}
