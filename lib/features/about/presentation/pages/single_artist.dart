import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/model/spotify_model.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/pages/provider/spotify_provider.dart';
import 'package:flutter_spotify_africa_assessment/features/widgets/afro_music_list.dart';
import 'package:flutter_spotify_africa_assessment/features/widgets/single_artist_card.dart';
import 'package:provider/provider.dart';

class SingleArtist extends StatefulWidget {
  final Items? item;
  const SingleArtist({super.key, this.item});

  @override
  State<SingleArtist> createState() => _SingleArtistState();
}

class _SingleArtistState extends State<SingleArtist> {
  List<Items>? items = [];
  @override
  void initState() {
    super.initState();
    SpotifyProvider spotifyProvider =
        Provider.of<SpotifyProvider>(context, listen: false);
    spotifyProvider.getSpotifyByCategoryId("afro").then((result) {
      setState(() {
        items = result ?? [];
      });
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleArtistCard(
                url: widget.item!.images![0].url.toString(),
                name: widget.item!.name.toString(),
                description: widget.item!.description.toString(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading:
                              Image.network("${items![index].images![0].url}"),
                          title: Text('${items![index].name}'),
                          subtitle: Text(
                            '${items![index].description}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(Icons.play_circle),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
