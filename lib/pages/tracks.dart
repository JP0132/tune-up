import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_up/constants/colours.dart';
import 'package:tune_up/constants/ourTextStyle.dart';
import 'package:get/get.dart';
import 'package:tune_up/controllers/player_controller.dart';
import 'package:tune_up/pages/player.dart';
import 'package:tune_up/widgets/customMarquee.dart';

class Tracks extends StatelessWidget {
  const Tracks({super.key});

  @override
  Widget build(BuildContext context) {
    var playerController = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: backgroundColour,
      body: FutureBuilder<List<SongModel>>(
          future: playerController.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL,
          ),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                "No Song Found",
                style: ourTextStyle(),
              ));
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: Obx(
                          () => ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: tilesBgColour,
                            title: buildMarquee(
                              snapshot.data![index].displayNameWOExt,
                              ourTextStyle(
                                fontWeight: FontWeight.bold,
                                size: 15,
                              ),
                              30,
                            ),
                            subtitle: buildMarquee(
                              "${snapshot.data![index].artist}",
                              ourTextStyle(size: 12),
                              50,
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(
                                Icons.music_note,
                                color: whiteColour,
                                size: 32,
                              ),
                            ),
                            trailing:
                                playerController.playIndex.value == index &&
                                        playerController.isPlaying.value
                                    ? const Icon(
                                        Icons.play_arrow,
                                        color: whiteColour,
                                        size: 26,
                                      )
                                    : null,
                            onTap: () {
                              Get.to(() => Player(
                                    data: snapshot.data!,
                                  ));
                              playerController.playSong(
                                  snapshot.data![index].uri, index);
                            },
                          ),
                        ));
                  },
                ),
              );
            }
          }),
    );
  }
}
