import 'package:flutter/material.dart';

class SingleArtistCard extends StatelessWidget {
  const SingleArtistCard(
      {super.key,
      required this.url,
      required this.name,
      this.description,
      this.followers});

  final String url;
  final String name;
  final String? description;
  final String? followers;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text(
              name,
              style: const TextStyle(fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
