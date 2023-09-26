import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_up/constants/colours.dart';
import 'package:tune_up/constants/ourTextStyle.dart';
import 'package:tune_up/controllers/player_controller.dart';
import 'package:tune_up/widgets/customMarquee.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;

  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final OnAudioQuery audioQuery = OnAudioQuery();
    // List<SongModel> songs = [];
    // Future<void> getAllSongs() async {
    //   songs = await audioQuery.querySongs();
    // }
    var playerController = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: backgroundColour,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: Container(
                  height: 300,
                  width: 300,
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: data[playerController.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: const Icon(Icons.music_note),
                    artworkFit:BoxFit.contain, 
                    
                    format:ArtworkFormat.PNG,
                    
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: tilesBgColour,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      buildMarquee(
                          data[playerController.playIndex.value]
                              .displayNameWOExt,
                          ourTextStyle(
                            colour: whiteColour,
                            fontWeight: FontWeight.w700,
                            size: 24,
                          ),
                          20,
                          40.0),
                      const SizedBox(
                        height: 12,
                      ),
                      buildMarquee(
                        data[playerController.playIndex.value]
                            .artist
                            .toString(),
                        ourTextStyle(
                          colour: whiteColour,
                          size: 20,
                        ),
                        30,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              playerController.position.value,
                              style: ourTextStyle(colour: whiteColour),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: whiteColour,
                                inactiveColor: backgroundColour,
                                activeColor: accentColour,
                                min: Duration(seconds: 0).inSeconds.toDouble(),
                                max: playerController.max.value,
                                value: playerController.value.value,
                                onChanged: (newValue) {
                                  playerController.changeDurationToSeconds(
                                      newValue.toInt());
                                  newValue = newValue;
                                },
                              ),
                            ),
                            Text(
                              playerController.duration.value,
                              style: ourTextStyle(colour: whiteColour),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              playerController.playSong(
                                  data[playerController.playIndex.value - 1]
                                      .uri,
                                  playerController.playIndex.value - 1);
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              size: 40,
                              color: whiteColour,
                            ),
                          ),
                          Obx(
                            () => IconButton(
                              onPressed: () {
                                if (playerController.isPlaying.value) {
                                  playerController.audioPlayer.pause();
                                  playerController.isPlaying(false);
                                } else {
                                  playerController.audioPlayer.play();
                                  playerController.isPlaying(true);
                                }
                              },
                              icon: playerController.isPlaying.value
                                  ? const Icon(
                                      Icons.pause,
                                      size: 54,
                                      color: whiteColour,
                                    )
                                  : const Icon(
                                      Icons.play_arrow_rounded,
                                      size: 54,
                                      color: whiteColour,
                                    ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              playerController.playSong(
                                data[playerController.playIndex.value + 1].uri,
                                playerController.playIndex.value + 1,
                              );
                            },
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              size: 40,
                              color: whiteColour,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// FutureBuilder<Uint8List?>(
//       future: audioQuery.queryArtwork(data[playerController.playIndex.value].id, ArtworkType.AUDIO),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return snapshot.data != null 
//             ? Image.memory(
//                 snapshot.data!,
//                 fit: BoxFit.contain,
//                 filterQuality: FilterQuality.high,
                
//               )
//             : const Icon(Icons.music_note);
//         } else {
//           return const CircularProgressIndicator();
//         }
//       },
//     )