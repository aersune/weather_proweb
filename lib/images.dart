import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'domain/models/images_serp.dart';

class ImageGenerator extends StatefulWidget {
  const ImageGenerator({Key? key}) : super(key: key);

  @override
  State<ImageGenerator> createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  TextEditingController controller = TextEditingController();
  var searchResult = 'tashkent';
  var searchNumb = Random().nextInt(10);


  var isDownload = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Weather app'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          extendBody: false,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              FutureBuilder<YandexImage>(
                  future: getImages(
                    searchResult.isNotEmpty ? searchResult : 'New york',
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .5,
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data!.imagesResults![searchNumb].original.toString(),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) =>  AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/cloud.gif'),
                                  opacity: 0.5,
                                  fit: BoxFit.cover,

                                )
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      );
                    }
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: controller,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.black26,
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          if (controller.text == searchResult) {
                            searchNumb = Random().nextInt(10);
                            FocusScope.of(context).unfocus();
                          } else if (controller.text.isNotEmpty) {
                            searchResult = controller.text;
                            FocusScope.of(context).unfocus();
                          } else {
                            null;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}