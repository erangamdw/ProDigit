import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/products_model.dart';

class DetailScreen extends StatelessWidget {
  final Products product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? "Product Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Slider
            if (product.images != null && product.images!.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(height: 250, autoPlay: true),
                items: product.images!.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://via.placeholder.com/250',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 250,
                          );
                        },
                      );
                    },
                  );
                }).toList(),
              )
            else
              Image.network(
                'https://via.placeholder.com/250',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            const SizedBox(height: 16.0),
            // Price
            Text(
              "Price: \$${product.price?.toStringAsFixed(2) ?? '0.00'}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            // Ratings
            Text(
              "Rating: ${product.rating?.toStringAsFixed(1) ?? 'N/A'} ⭐",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            // Description
            Text(
              product.description ?? "No Description Available",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
