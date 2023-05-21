import 'package:flutter/material.dart';

class SingleArtistCard extends StatelessWidget {
  const SingleArtistCard({
    super.key,
    required this.url,
    required this.name,
    required this.description,
  });

  final String url;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: [
              SizedBox(
                height: 250,
                child: Image.network(
                  url, // Replace with your own image path
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Icon(
                    Icons.play_circle,
                    size: 80,
                    color: Colors.grey.shade400,
                  ))
            ],
          ),
          ListTile(
            title: Text(
              name,
              style: const TextStyle(fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(description, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 10),
          const Divider(height: 20, color: Colors.grey),
        ],
      ),
    );
  }
}
