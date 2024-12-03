import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/products_model.dart';

class ProductsController extends GetxController {
  // Observable variables
  var productsData = ProductsDataModal().obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  // Dummy Endpoint
  final String apiUrl = "https://dummyjson.com/products";

  // Fetch data method
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        productsData.value = ProductsDataModal.fromJson(jsonData);
      } else {
        errorMessage.value = "Failed to load products: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
}
