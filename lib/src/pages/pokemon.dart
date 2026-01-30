import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class Pokemon extends StatelessWidget {
    Pokemon({super.key});

    final List<String> listPokemons = [
    'Bulbasaur',
    'Ivysaur',
    'Venusaur',
    'Charmander',
    'Charmeleon',
    'Charizard',
    'Squirtle',
    'Wartortle',
    ];

  @override
  Widget build(BuildContext context) {
    debugPrint('=== BUILD DIPANGGIL ===');

    listPokemons.forEach((element) {
    debugPrint("Pokemon: $element");
  });

    return Scaffold(
        appBar: AppBar(
          title: Text('Pokemon Page'),
        ),
        // body: Image.asset('images/bullbasaur.png'),
        body: ListView.builder(
            itemCount: listPokemons.length,
            itemBuilder: (context, index) {
                return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                    leading: CircleAvatar(
                        child: Text(listPokemons[index][0]),
                    ),
                    title: Text(listPokemons[index], style: TextStyle(fontSize: 18)),
                ),
                );
            },
        )
    );
  }
}