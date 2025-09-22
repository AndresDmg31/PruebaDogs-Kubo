import 'package:flutter/material.dart';
import 'package:dogs/data/services/dog_api_service.dart';
import 'package:dogs/domain/entities/breed.dart';

class BreedsProvider extends ChangeNotifier {
  List<Breed>? _breeds;
  LoadStatus _status = LoadStatus.idle;
  String? _errorMessage;

  List<Breed> get breeds => _breeds ?? [];
  LoadStatus get status => _status;
  String? get errorMessage => _errorMessage;


  void _setLoading(){
    _status = LoadStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setSuccess(List<Breed> data) {
    _breeds = data;
    _status = LoadStatus.success;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = LoadStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  void clearError(){
    _errorMessage = null;
  }

  Future<void> getBreed() async {
    if (_breeds != null && _breeds!.isNotEmpty) return;

    _setLoading();
    try {
      final service = BreedService();
      final data = await service.getBreed();
      _setSuccess(data);
    } catch (e) {
      _setError("Eror, Revisa tu conexion e intenta de nuevo.");
    }
  }
}
