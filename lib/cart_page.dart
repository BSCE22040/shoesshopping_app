import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/cart_provider.dart';

/// CartPage displays all items added to the shopping cart
/// 
/// This page shows a list of products that the user has added to their cart.
/// Users can view product details, see the selected size, and remove items.
/// The cart state is managed using Provider pattern for state management.
/// 
/// Features:
/// - Displays product image, title, and selected size
/// - Allows removal of items with confirmation dialog
/// - Shows empty cart message when no items exist
/// - Calculates and displays total cart value
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the cart data from CartProvider
    // Using Provider.of to listen to cart changes
    final cart = Provider.of<CartProvider>(context).cart;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        // Display cart item count in the app bar
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '${cart.length} items',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      // Show empty cart message if cart is empty, otherwise show cart items
      body: cart.isEmpty 
          ? _buildEmptyCartMessage(context)
          : _buildCartList(context, cart),
      // Add bottom bar with total price and checkout button
      bottomNavigationBar: cart.isEmpty 
          ? null 
          : _buildCartSummary(context, cart),
    );
  }

  /// Builds the list view of cart items
  /// 
  /// Creates a scrollable list displaying all products in the cart
  /// Each item shows product image, title, size, and delete button
  Widget _buildCartList(BuildContext context, List<Map<String, dynamic>> cart) {
    return ListView.builder(
      itemCount: cart.length,
      itemBuilder: (context, index) {
        final cartItem = cart[index];
        return _buildCartItem(context, cartItem);
      },
    );
  }

  /// Builds a single cart item widget
  /// 
  /// Displays product information including:
  /// - Circular product image
  /// - Product title
  /// - Selected size
  /// - Delete button with confirmation dialog
  Widget _buildCartItem(BuildContext context, Map<String, dynamic> cartItem) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        // Product image in a circular avatar
        leading: CircleAvatar(
          backgroundImage: AssetImage(cartItem['imageUrl'] as String),
          radius: 30,
        ),
        // Delete button that shows confirmation dialog
        trailing: IconButton(
          onPressed: () {
            _showRemoveDialog(context, cartItem);
          },
          icon: const Icon(Icons.delete, color: Colors.red),
          tooltip: 'Remove from cart',
        ),
        // Product title with custom theme styling
        title: Text(
          cartItem['title'].toString(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        // Display selected size
        subtitle: Text('Size: ${cartItem['sizes']}'),
      ),
    );
  }

  /// Shows confirmation dialog before removing item from cart
  /// 
  /// Displays an alert dialog asking user to confirm product removal
  /// Provides 'Yes' to confirm removal and 'No' to cancel
  /// Uses Provider to remove product if user confirms
  void _showRemoveDialog(BuildContext context, Map<String, dynamic> cartItem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Dialog title
          title: Text(
            "Remove Product From Cart",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          // Confirmation message
          content: const Text(
            "Are You Sure You Want to Remove the Product From Your Cart?"
          ),
          // Action buttons
          actions: [
            // Yes button - removes product
            TextButton(
              onPressed: () {
                _removeProductFromCart(context, cartItem);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            // No button - cancels removal
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Removes the specified product from cart
  /// 
  /// Uses CartProvider to remove product without listening to changes
  /// This prevents unnecessary rebuilds during the removal operation
  void _removeProductFromCart(BuildContext context, Map<String, dynamic> cartItem) {
    Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
    
    // Show snackbar confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${cartItem['title']} removed from cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Builds empty cart message widget
  /// 
  /// Displays a centered message when cart has no items
  /// Shows an icon and helpful text to guide user
  Widget _buildEmptyCartMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'Your cart is empty',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Add some products to get started!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds cart summary section with total and checkout button
  /// 
  /// Displays total price and provides checkout functionality
  /// Positioned at bottom of screen for easy access
  Widget _buildCartSummary(BuildContext context, List<Map<String, dynamic>> cart) {
    // Calculate total price from all cart items
    double total = _calculateTotal(cart);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Display total price
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Checkout button
          ElevatedButton(
            onPressed: () => _handleCheckout(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }

  /// Calculates total price of all items in cart
  /// 
  /// Sums up the price of each product in the cart
  /// Returns 0.0 if cart is empty
  double _calculateTotal(List<Map<String, dynamic>> cart) {
    double total = 0.0;
    for (var item in cart) {
      // Assuming each cart item has a 'price' field
      total += (item['price'] as num?)?.toDouble() ?? 0.0;
    }
    return total;
  }

  /// Handles checkout process
  /// 
  /// Initiates the checkout flow when user taps checkout button
  /// Can be extended to navigate to payment page
  void _handleCheckout(BuildContext context) {
    // TODO: Navigate to checkout page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Proceeding to checkout...'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}