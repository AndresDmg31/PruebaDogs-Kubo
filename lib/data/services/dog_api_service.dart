import 'package:dogs/data/local/secure_storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:dogs/domain/entities/breed.dart';
import 'package:dogs/global/environment.dart';

class BreedService {
  Future<List<Breed>> getBreed() async {
    final url = Uri.parse(Environment.apiUrl);
    final key = await SecureStorageService.getApiKey();

    final headers = {
      "content-type": "aplication/json",
      "x-api-key": key ?? "",
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return breedFromJson(response.body);
    } else {
      throw Exception("Error ${response.statusCode} al obtener las razas");
    }
  }
}
