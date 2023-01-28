// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class BigImageInfo extends StatelessWidget {
  const BigImageInfo({Key? key, required this.imageURL}) : super(key: key);
  final String imageURL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            //padding: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: CachedNetworkImage(
              imageUrl: imageURL,
              imageBuilder: (context, imageProvider) => Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8),
                //   image: DecorationImage(
                //     image: imageProvider,
                //     fit: BoxFit.fitWidth,
                //   ),
                // ),
                child: PhotoView(
                  imageProvider: NetworkImage(imageURL),
                ),
              ),
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                color: MainColors.fromHex(MainColors.colorGreen),
              )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: MainColors.fromHex(MainColors.colorGreen),
                  )))
        ],
      ),
    );
  }
}
