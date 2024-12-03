import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initialize the ProductsController
  final ProductsController _controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        // Error check
        if (_controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(_controller.errorMessage.value));
        }
        // Display the list of products
        return ListView.builder(
          itemCount: _controller.productsData.value.products?.length ?? 0,
          itemBuilder: (context, index) {
            final product = _controller.productsData.value.products![index];
            return ListTile(
              leading: product.thumbnail != null
                  ? Image.network(product.thumbnail!, width: 50, height: 50)
                  : const Icon(Icons.image_not_supported),
              title: Text(product.title ?? "No Title"),
              subtitle: Text("\$${product.price?.toStringAsFixed(2) ?? '0.00'}"),
            );
          },
        );
      }),
    );
  }
}
