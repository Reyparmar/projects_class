import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mate/src/utils/constants.dart';
import 'package:mate/src/utils/urls.dart';

class LoadNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final bool? isClickable;
  final BoxFit? fit;

  const LoadNetworkImage(
      {Key? key,
      required this.imageUrl,
      this.width,
      this.height,
      this.isClickable = true,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isClickable ?? false) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  child: Stack(
                    children: [
                      LoadNetworkImage(
                        imageUrl: imageUrl,
                        isClickable: false,
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
      child: CachedNetworkImage(
        fadeInCurve: Curves.bounceIn,
        imageUrl: imageUrl,
        cacheKey: UrlUtils.stripQueryParams(imageUrl),
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(
            color: AppColor.purpleColor,
            value: downloadProgress.progress,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
        ),
      ),
    );
  }
}
