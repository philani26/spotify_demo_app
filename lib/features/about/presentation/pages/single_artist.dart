import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/model/spotify_model.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/pages/provider/spotify_provider.dart';
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleArtistCard(
                url: widget.item!.images![0].url.toString(),
                name: widget.item!.name.toString(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(widget.item!.description.toString(),
                    overflow: TextOverflow.ellipsis),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 200, top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                        color: Color(0xff211F26)),
                    child: ListTile(
                      trailing: Text('${widget.item!.tracks!.total} followers'),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color(0xff0077C8),
                        Color(0xff00B0B9),
                        Color(0xff3A913F),
                      ],
                    )),
                  ),
                ),
              ],
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
