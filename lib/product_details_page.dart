import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/cart_provider.dart';
class ProductDetailsPage extends StatefulWidget {
  final Map<String , Object > product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedsize=0;
  void onTap(){
    if(selectedsize!=0){  Provider.of<CartProvider>(context,listen: false)
                        .addProduct({
                          'id': widget.product['id'],
    'title': widget.product['title'],
    'price': widget.product['price'],
    'imageUrl': widget.product['imageUrl'],
    'company': widget.product['company'],
    'sizes': selectedsize,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Added Successfully"),),);
                        }
                        
                        else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select Size"),),);
                        }
                      
                      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
          style: Theme.of(context).textTheme.titleLarge,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl']as String,
            height:250,
            ),
          ),
          Spacer(flex: 2),
          Container(
            height: 196,
            decoration: BoxDecoration(
              color: Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(40),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (widget.product['sizes'] as List<int>).length,
                        itemBuilder: (context,index){
                          final size=(widget.product['sizes']as List <int>)[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedsize=size;
                                });
                              },
                              child: Chip(
                                label: Text(size.toString()),
                                backgroundColor: selectedsize==size? Colors.amber : null ,
                              ),
                            ),
                          );
                        },
                      
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        fixedSize: Size(300, 50),
                      ),
                      child: Text("Add To Cart",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
            
                      ), 
                      
                      ) ,
                      
                      ),
                    ),


            ],
            ),
          ),
        ],
      ),

    );
  }
}