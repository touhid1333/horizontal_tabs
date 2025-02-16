import 'package:flutter/material.dart';
import 'package:horizontal_tabs/horizontal_tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Horizontal Tabs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Simple Horizontal Tabs :",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HorizontalTabView.simple(
                height: 70,
                width: double.maxFinite,
                backgroundColor: Colors.green,
                unselectedBackgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                unselectedForegroundColor: Colors.white,
                selectedItem: _index,
                itemTitles: const ["Home", "Orders", "Cart", "Profile"],
                itemIcons: const [
                  Icons.home,
                  Icons.bookmark_border,
                  Icons.shopping_cart,
                  Icons.person
                ],
                onTap: (p0) {
                  setState(() {
                    _index = p0;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Rounded Horizontal Tabs :",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HorizontalTabView.rounded(
                height: 90,
                backgroundColor: Colors.green,
                unselectedBackgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                unselectedForegroundColor: Colors.white,
                selectedItem: _index,
                itemTitles: const ["Home", "Orders", "Cart", "Profile"],
                itemIcons: const [
                  Icons.home,
                  Icons.bookmark_border,
                  Icons.shopping_cart,
                  Icons.person
                ],
                onTap: (p0) {
                  setState(() {
                    _index = p0;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Box Horizontal Tabs :",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HorizontalTabView.box(
                selectedItem: _index,
                onTap: (p0) {
                  setState(() {
                    _index = p0;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
