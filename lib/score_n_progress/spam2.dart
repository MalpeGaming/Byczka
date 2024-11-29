import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rozbudowana Aplikacja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedTabIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    SettingsTab(),
    AboutTab(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rozbudowana Aplikacja'),
        centerTitle: true,
      ),
      body: _pages[_selectedTabIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kliknięto przycisk akcji!')),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dom'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Ustawienia'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'O aplikacji'),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Witaj w aplikacji!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 4.0,
          child: ListTile(
            leading: const Icon(Icons.star, color: Colors.amber),
            title: const Text('Polecane funkcje'),
            subtitle: const Text('Poznaj funkcje aplikacji!'),
            trailing: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kliknięto funkcję!')),
                );
              },
              child: const Text('Otwórz'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(
            6,
            (index) => ElevatedButton.icon(
              icon: const Icon(Icons.featured_play_list),
              label: Text('Funkcja ${index + 1}'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Funkcja ${index + 1} kliknięta!')),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ustawienia',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.wifi),
            title: const Text('Połączenie Wi-Fi'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wi-Fi zmieniono!')),
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Tryb ciemny'),
            trailing: Switch(
              value: false,
              onChanged: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tryb ciemny zmieniono!')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info, size: 100, color: Colors.blue),
          const SizedBox(height: 16),
          const Text(
            'O aplikacji',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'To jest przykładowa aplikacja Flutter z wieloma funkcjami. '
            'Wykorzystuje różne komponenty do demonstracji możliwości frameworka.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
