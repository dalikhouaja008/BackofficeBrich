import 'package:brichbackoffice/config/utils/network/CheckInternetConnectivity.dart';
import 'package:brichbackoffice/data/entities/PredictionResponse.dart';
import 'package:dio/dio.dart';


class CurrencyConverterRepository {
  final Dio dio;

  CurrencyConverterRepository(this.dio);

Future<double> getSellingRate(String currency, String amount) async {
   try {
     // Utilisez le chemin complet avec les paramètres
     final response = await dio.get(
       'http://192.168.1.102:3000/exchange-rate/sellingRate/$currency/$amount'
     );
     
     print('Selling rate result: ${response.data}');
     print('Type de données: ${response.data.runtimeType}');
     
     // Conversion explicite en double
     if (response.data is num) {
       return (response.data as num).toDouble();
     } else if (response.data is String) {
       return double.parse(response.data);
     } else {
       throw Exception('Format de réponse inattendu');
     }
   } catch (e) {
     print('Error getting selling rate: $e');
     
     // Si c'est une erreur Dio, afficher plus de détails
     if (e is DioException) {
       print('Type d\'erreur Dio: ${e.type}');
       print('Message d\'erreur: ${e.message}');
       print('Réponse d\'erreur: ${e.response?.data}');
     }
     
     rethrow; // Relancez l'exception pour une gestion plus précise
   }
}
Future<double> getBuyingRate(String currency, String amount) async {
   try {
     // Utilisez le chemin complet avec les paramètres de chemin
     final response = await dio.get(
       'http://192.168.1.102:3000/exchange-rate/buyingRate/$currency/$amount'
     );
     
     print('Buying rate result: ${response.data}');
     print('Type de données: ${response.data.runtimeType}');
     
     // Conversion explicite en double
     if (response.data is num) {
       return (response.data as num).toDouble();
     } else if (response.data is String) {
       return double.parse(response.data);
     } else {
       throw Exception('Format de réponse inattendu');
     }
   } catch (e) {
     print('Error getting buying rate: $e');
     
     // Si c'est une erreur Dio, afficher plus de détails
     if (e is DioException) {
       print('Type d\'erreur Dio: ${e.type}');
       print('Message d\'erreur: ${e.message}');
       print('Réponse d\'erreur: ${e.response?.data}');
     }
     
     rethrow; // Relancez l'exception pour une gestion plus précise
   }
}




Future<Response> fetchExchangeRates() async {
  try {
    // Vérifiez d'abord la connexion internet
    bool isConnected = await checkInternetConnectivity();
    if (!isConnected) {
      throw Exception('Pas de connexion internet');
    }

    final response = await dio.get('http://192.168.1.102:3000/exchange-rate');
    return response;
  } on DioException catch (e) {
    // Gestion spécifique des erreurs Dio
    if (e.type == DioExceptionType.connectionTimeout) {
      throw Exception('Délai de connexion dépassé');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      throw Exception('Délai de réception dépassé');
    } else if (e.type == DioExceptionType.badResponse) {
      throw Exception('Réponse du serveur invalide');
    } else {
      throw Exception('Erreur de connexion');
    }
  } catch (e) {
    throw Exception('Erreur inattendue: $e');
  }
}
Future<Response<PredictionResponse>> getCurrencyPredictions({
    required String date,
    required List<String> currencies,
}) async {
    try {
        final response = await dio.post(
            'http://192.168.1.102:3000/prediction/create-prediction',
            data: {
                'date': date,
                'currencies': currencies,
            },
        );
        
        return Response(
            data: PredictionResponse.fromJson(response.data),
            statusCode: response.statusCode,
            requestOptions: response.requestOptions,
        );
    } catch (e) {
        print('Error fetching predictions: $e'); // Log the error
        
        return Response(
            data: PredictionResponse(
                predictions: {}, 
                startDate: '',
                error: e.toString() // Optional: include error details
            ),
            statusCode: 500,
            requestOptions: RequestOptions(path: 'http://192.168.1.102:3000/prediction/create-prediction'),
        );
    }
}
}
