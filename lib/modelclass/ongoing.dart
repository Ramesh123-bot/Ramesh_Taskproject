import 'package:flutter/material.dart';
import 'package:ramesh_app/Allscrenn.dart';
import 'package:ramesh_app/modelclass/completed.dart';

import '../header.dart';

void main() => runApp(const Ongoing());

class Ongoing extends StatelessWidget {
  const Ongoing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text(
                'projects',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Header(),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: ListPage(),
              ),
            ],
          ),
        ));
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const ProductItem({Key? key, required this.product, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 230,
          // Set a fixed height for the product item container
          decoration: BoxDecoration(
            color: product.color,
            //borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 242, 233, 233).withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final Color color;
  final String image;

  Product({
    required this.name,
    required this.color,
    required this.image,
  });
}

class ListPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'App Animation',
      color: Colors.greenAccent,
      image: 'lib/images/ongoing.jpg',
    ),
    Product(
      name: 'Dashboard Design',
      color: Colors.blueAccent,
      image: 'lib/images/completed.jpg',
    ),
    Product(
      name: 'UI/UX Design',
      color: Colors.redAccent,
      image: 'lib/images/cancel.png',
    ),
  ];

  ListPage({Key? key}) : super(key: key);

  void _navigateToScreen(BuildContext context, String itemName) {
    if (itemName == 'App Animation') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AllScrenn(),
        ),
      );
    } else if (itemName == 'Dashboard Design') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Ongoing(),
        ),
      );
    } else if (itemName == 'UI/UX Design') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Completed(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.all(0),
      child: Column(
        children: List.generate(
          products.length,
          (index) => Padding(
            padding: const EdgeInsets.all(0),
            child: ProductItem(
              product: products[index],
              onTap: () {
                _navigateToScreen(context, products[index].name);
              },
            ),
          ),
        ),
      ),
    );
  }
}
