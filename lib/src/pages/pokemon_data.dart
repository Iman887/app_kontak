import 'package:app_kontak/src/data/pokemon_model.dart';
import 'package:flutter/material.dart';

class PokemonData extends StatelessWidget {
  PokemonData({super.key});

  final List<PokemonModel> listPokemons = [
    PokemonModel(name: 'Bulbasaur', image: 'images/bullbasaur.png'),
    PokemonModel(name: 'Charmander', image: 'images/charmander.png'),
    PokemonModel(name: 'Eevee', image: 'images/eevee.png'),
    PokemonModel(name: 'Pidgey', image: 'images/pidgey.png'),
    PokemonModel(name: 'Pikachu', image: 'images/pikachu.png'),
    PokemonModel(name: 'Pokeball', image: 'images/pokeball.png'),
    PokemonModel(name: 'Rattata', image: 'images/rattata.png'),
    PokemonModel(name: 'Snorlax', image: 'images/snorlax.png'),
    PokemonModel(name: 'Squirtle', image: 'images/squirtle.png'),
    PokemonModel(name: 'Zubat', image: 'images/zubat.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokemon Page')),
      body: ListView.builder(
        itemCount: listPokemons.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 50,
                  padding: EdgeInsets.all(8),
                  child: Image.asset(listPokemons[index].image),
                ),
                SizedBox(width: 12),
                Text(listPokemons[index].name, style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
