import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/core/failure/failure.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/model/single_catagory.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/model/spotify_model.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/pages/provider/spotify_provider.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SpotifyCategory extends StatefulWidget {
  String categoryId = "afro";

  SpotifyCategory({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<SpotifyCategory> createState() => _SpotifyCategoryState();
}

class _SpotifyCategoryState extends State<SpotifyCategory> {
  List<Items>? items = [];
  SingleCatagory? singleCatagory;
  late SpotifyProvider spotifyProvider;
  late SpotifyProvider getCatagory;
  @override
  void initState() {
    super.initState();
    spotifyProvider = Provider.of<SpotifyProvider>(context, listen: false);
    spotifyProvider.getSpotifyByCategoryId(widget.categoryId).then((result) {
      setState(() {
        items = result ?? [];
      });
    }).catchError((error) {
      throw ServerFailure(errorMessage: 'Sorry the issue is on our side');
    });
    getCatagory = Provider.of<SpotifyProvider>(context, listen: false);
    getCatagory.getSingleCatagory(widget.categoryId).then((result) {
      setState(() {
        singleCatagory = result ?? [];
      });
    }).catchError((error) {
      throw ServerFailure(errorMessage: 'Sorry the issue is on our side');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Afro"),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.about),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  AppColors.blue,
                  AppColors.cyan,
                  AppColors.green,
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder<dynamic>(
                    future: getCatagory.getSingleCatagory(widget.categoryId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        return Card(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 72,
                                width: 72,
                                child: Image.network(
                                  data!.icons![0].url.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Afro',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Text(
                                'playlists',
                                style: TextStyle(fontSize: 28),
                              )
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    children: List.generate(items!.length, (index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              AppRoutes.singleArtist,
                              arguments: items![index]);
                        },
                        child: Card(
                          elevation: 2.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.network(
                                '${items![index].images![0].url}',
                                fit: BoxFit.cover,
                                height: 130.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${items![index].name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
