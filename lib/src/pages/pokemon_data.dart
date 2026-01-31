import 'dart:math';

import 'package:app_kontak/src/data/pokemon_model.dart';
import 'package:app_kontak/src/pages/add_contact_page.dart';
import 'package:flutter/material.dart';

class PokemonData extends StatefulWidget {
  const PokemonData({super.key});

  @override
  State<PokemonData> createState() => _PokemonDataState();
}

class _PokemonDataState extends State<PokemonData> {
  int _currentIndex = 0;

  // contacts stored as maps with keys 'name' and 'phone'
  final List<Map<String, String>> contacts = [];

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

  void _confirmDelete(int index) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Hapus Kontak'),
      content: Text('Apakah Anda yakin ingin menghapus ${contacts[index]['name']}?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              contacts.removeAt(index);
            });
            Navigator.pop(context);
          },
          child: const Text('Hapus', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Pokemon Page' : 'Contact Page'),
      ),

      body: _currentIndex == 0 ? _buildHome() : _buildContact(),

      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              onPressed: _openAddContactPage,
              tooltip: 'Add Contact',
              child: const Icon(Icons.add),
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Contact',
          ),
        ],
      ),
    );
  }

  Future<void> _openAddContactPage() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const AddContactPage()),
    );

    if (result != null &&
        result.containsKey('name') &&
        result.containsKey('phone')) {
      // pick a random pokemon image as avatar for this contact
      final rnd = Random();
      final avatarImage = listPokemons[rnd.nextInt(listPokemons.length)].image;

      setState(() {
        contacts.add({
          'name': result['name']!,
          'phone': result['phone']!,
          'avatar': avatarImage,
        });
      });
    }
  }

  /// ================= HOME PAGE =================
  Widget _buildHome() {
    return ListView.builder(
      itemCount: listPokemons.length,
      itemBuilder: (context, index) {
        final pokemon = listPokemons[index];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 50,
                padding: const EdgeInsets.all(8),
                child: Image.asset(pokemon.image),
              ),
              const SizedBox(width: 12),
              Text(pokemon.name, style: const TextStyle(fontSize: 18)),
            ],
          ),
        );
      },
    );
  }

  /// ================= CONTACT PAGE =================
  Widget _buildContact() {
    if (contacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.contact_page, size: 64),
            SizedBox(height: 12),
            Text('Contact Page', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Tap + to add a contact'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final c = contacts[index];
        final name = c['name'] ?? '';
        final phone = c['phone'] ?? '';

        final avatar = c['avatar'] ?? 'images/pikachu.png';
        final pokemon = listPokemons.firstWhere(
          (p) => p.image == avatar,
          orElse: () => PokemonModel(name: 'Unknown', image: ''),
        );

        return ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(avatar)),
            title: Row(
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  ' (${pokemon.name})',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            subtitle: Text(phone),
            // Tambahkan trailing untuk tombol delete di pojok kanan
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Tampilkan dialog konfirmasi sebelum hapus (Opsional tapi disarankan)
                _confirmDelete(index);
              },
            ),
          );
      },
    );
  }
}
