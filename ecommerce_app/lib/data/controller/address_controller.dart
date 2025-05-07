import 'package:ecommerce_app/data/services/address_api_service.dart';

class AddressAPIController {
  final AddressAPIService _addressAPIService = AddressAPIService();

  Future<List<String>> getData(String? filter) async {
    return _addressAPIService.searchAddress(filter);
  }
}