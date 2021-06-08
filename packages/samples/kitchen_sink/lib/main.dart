import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kitchen_sink/counter.dart';
import 'package:studio/studio.dart';

import 'landing_screen.dart';

void main() {
  MyApp().run();
  //runApp(App());
}

final value1 = Value(0);
final value2 = Value(0);
final combo = Combo([value1, value2]);

class MyApp extends App {
  @override
  void onCreate() {
    super.onCreate();

    module //
      ..dependency(() => RayonSerializer())
      ..dependency(() => FamilleSerializer())
      ..dependency(() => SousFamilleSerializer())
      ..dependency(() => ProduitSerializer());
  }

  @override
  Widget build(BuildContext context) {
    return LandingScreen();
  }
}

class Rayon {
  final int id;
  final String name;
  final List<Famille> familles;

  Rayon({
    this.id,
    this.name,
    this.familles,
  });
}

class Famille {
  final int id;
  final String name;
  final List<SousFamille> sousFamilles;

  Famille({
    this.id,
    this.name,
    this.sousFamilles,
  });
}

class SousFamille {
  final int id;
  final String name;
  final List<Produit> produits;

  SousFamille({
    this.id,
    this.name,
    this.produits,
  });
}

class Produit {
  final int id;
  final String primary;
  final String secondary;
  final bool isPromo;
  final double price;
  final List<int> ids;

  Produit({
    this.id,
    this.primary,
    this.secondary,
    this.isPromo,
    this.price,
    this.ids,
  });
}

final json = '''

    {
      "id": 0,
      "name": "Rayon 0",
      "familles": [
        {
          "id": 0,
          "name": "Rayon 0 - Famille 0",
          "sousFamilles": [
            {
              "id": 0,
              "name": "Rayon 0 - Famille 0 - SousFamille 0",
              "produits": [
                {
                  "id": 0,
                  "primary": "Produit 0",
                  "secondary": "Rayon 0 - Famille 0 - SousFamille 0",
                  "price": 1,
                  "isPromo": true,
                  "ids": []
                },
                {
                  "id": 0,
                  "primary": "Produit 1",
                  "secondary": "Rayon 0 - Famille 0 - SousFamille 0",
                  "price": 1,
                  "isPromo": true,
                  "ids": [0,1,2,3]
                },
                {
                  "id": 0,
                  "primary": "Produit 2",
                  "secondary": "Rayon 0 - Famille 0 - SousFamille 0",
                  "price": 2.5,
                  "isPromo": false,
                  "ids": [0,1,2,3]
                }
              ]
            }
          ]
        }
      ]
    }
  
'''
    .trim();

class RayonSerializer extends Serializer<Rayon> {
  @override
  Rayon deserialize(Serialized value) {
    return Rayon(
      id: value.get('id'),
      name: value.get('name'),
      familles: value.get('familles'),
    );
  }

  @override
  Serializable serialize(Rayon value) {
    return Serializable() //
      ..set('id', value.id)
      ..set('name', value.name)
      ..set('familles', value.familles);
  }
}

class FamilleSerializer extends Serializer<Famille> {
  @override
  Famille deserialize(Serialized value) {
    return Famille(
      id: value.get('id'),
      name: value.get('name'),
      sousFamilles: value.get('sousFamilles'),
    );
  }

  @override
  Serializable serialize(Famille value) {
    return Serializable() //
      ..set('id', value.id)
      ..set('name', value.name)
      ..set('sousFamilles', value.sousFamilles);
  }
}

class SousFamilleSerializer extends Serializer<SousFamille> {
  @override
  SousFamille deserialize(Serialized value) {
    return SousFamille(
      id: value.get('id'),
      name: value.get('name'),
      produits: value.get('produits'),
    );
  }

  @override
  Serializable serialize(SousFamille value) {
    return Serializable() //
      ..set('id', value.id)
      ..set('name', value.name)
      ..set('produits', value.produits);
  }
}

class ProduitSerializer extends Serializer<Produit> {
  @override
  Produit deserialize(Serialized value) {
    return Produit(
      id: value.get('id'),
      primary: value.get('primary'),
      secondary: value.get('secondary'),
      isPromo: value.get('isPromo'),
      price: value.get('price'),
      ids: value.get('ids'),
    );
  }

  @override
  Serializable serialize(Produit value) {
    return Serializable() //
      ..set('id', value.id)
      ..set('primary', value.primary)
      ..set('secondary', value.secondary)
      ..set('isPromo', value.isPromo)
      ..set('price', value.price);
  }
}
