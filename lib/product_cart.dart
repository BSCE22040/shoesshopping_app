import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final Color backgroundColor;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 5),
            Text('\$$price', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20), // Rounded image corners
              child: Image.asset(
                image,
                height: 175,
                fit: BoxFit.cover, // Ensure the image covers the container
              ),
            ),
          ],
        ),
      ),
    );
  }
}
