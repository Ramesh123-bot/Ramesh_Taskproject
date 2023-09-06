import 'package:flutter/material.dart';
import 'package:ramesh_app/profilepage.dart';
import 'APIfunction/api interaction.dart';
import 'modelclass/cancel.dart';
import 'modelclass/completed.dart';
import 'modelclass/inprogress.dart';
import 'modelclass/ongoing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        useMaterial3: true,
      ),
      home: const MyAppScaffold(),
    );
  }
}

class MyAppScaffold extends StatefulWidget {
  const MyAppScaffold({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppScaffoldState createState() => _MyAppScaffoldState();
}

class _MyAppScaffoldState extends State<MyAppScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ProductScreen(),
    const Ongoing(),
    const Completed(),
    const Cancel()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black54,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RepositoryList(),
                ),
              );
            },
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.black,
                foregroundImage: AssetImage('lib/images/profile.png'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            );
          },
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(radius: 35, child: Icon(Icons.add)),
            label: 'ADD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Mail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
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

class ProductScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'In Progress',
      color: Colors.orangeAccent,
      image: 'lib/images/inprogress.png',
    ),
    Product(
      name: 'Ongoing',
      color: Colors.blueAccent,
      image: 'lib/images/ongoing.jpg',
    ),
    Product(
      name: 'Completed',
      color: Colors.greenAccent,
      image: 'lib/images/completed.jpg',
    ),
    Product(
      name: 'Cancel',
      color: Colors.redAccent,
      image: 'lib/images/cancel.png',
    ),
  ];

  ProductScreen({super.key});

  void _navigateToScreen(BuildContext context, String itemName) {
    if (itemName == 'In Progress') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Inprogress(),
        ),
      );
    } else if (itemName == 'Ongoing') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Ongoing(),
        ),
      );
    } else if (itemName == 'Completed') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Completed(),
        ),
      );
    } else if (itemName == 'Cancel') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Cancel(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Column(
              children: [
                Text('Hello',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                Text('Ramesh',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return ProductItem(
            product: products[index],
            onTap: () {
              _navigateToScreen(context, products[index].name);
            },
          );
        },
      ),
    );
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
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: onTap,
          child: Hero(
            tag: 'product_${product.name}',
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 242, 233, 233)
                        .withOpacity(0.3),
                    spreadRadius: 8,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(product.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        product.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
