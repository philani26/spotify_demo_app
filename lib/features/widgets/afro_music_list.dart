import 'package:flutter/material.dart';

class AfroMusicList extends StatelessWidget {
  const AfroMusicList({super.key, required this.length, required this.url, required this.name, required this.description});
  final int length;
  final String url;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Image.network(url),
                    title: Text(name),
                    subtitle: Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.play_circle),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
