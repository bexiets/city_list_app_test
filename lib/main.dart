import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'providers/city_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CityListScreen(),
    );
  }
}
class CityListScreen extends HookConsumerWidget { 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityProviderState = ref.watch(cityProviderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('City List'),
      ),
      body: cityProviderState.when(
        data: (cities) {
          return ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cities[index].name),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

