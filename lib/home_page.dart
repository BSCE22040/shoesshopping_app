import 'package:flutter/material.dart';
import 'package:shop_app_flutter/cart_page.dart';

import 'package:shop_app_flutter/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  
int currentpage=0;
  List<Widget> pages=[
    ProductList(),
    CartPage()
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: IndexedStack(
        index: currentpage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 27,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (value) {
          setState(() {
            currentpage=value;
          });
        },
        currentIndex: currentpage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
            ),
        ],
        ),    
    );
  }
}
