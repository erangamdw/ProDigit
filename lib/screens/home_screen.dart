import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import 'detail_screen.dart';

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
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _controller.productsData.value.products?.length ?? 0,
              itemBuilder: (context, index) {
                final product = _controller.productsData.value.products![index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      product.thumbnail ?? 'https://via.placeholder.com/50',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.title ?? "No Title"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("\$${product.price?.toStringAsFixed(2) ?? '0.00'}"),
                        Text("Brand: ${product.brand ?? 'No Brand'}"),
                      ],
                    ),
                    onTap: () {
                      Get.to(() => DetailScreen(product: product));
                    },
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
