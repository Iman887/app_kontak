class PokemonModel {
  final String name;
  final String image;

  PokemonModel({required this.name, required this.image});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      image: json['image'],
    );
  }
}