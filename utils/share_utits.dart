import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class ShareUtils {
  static Future<String> sharePost(
    String type,
    String id,
    String title,
    String categorySlug,
    String? image,
  ) async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: "https://lfb.page.link",
      link: Uri.parse("https://lfb.page.link/type=$type&id=$id"),
      androidParameters: AndroidParameters(
        packageName: 'com.lfb.learnfromblogs',
        minimumVersion: 21,
      ),
      //TODO ios setting
      iosParameters: IOSParameters(
        bundleId: 'com.lfb.learnfromblogs',
        minimumVersion: '0',
      ),
      // googleAnalyticsParameters: GoogleAnalyticsParameters(
      //   campaign: 'example-promo',
      //   medium: 'social',
      //   source: 'orkut',
      // ),
      // itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
      //   providerToken: '123456',
      //   campaignToken: 'example-promo',
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "$title",
        description: "$categorySlug",
        imageUrl: image != null ? Uri.parse(image) : null,
      ),
    );

    Uri url;
    final ShortDynamicLink shortLink =
        await dynamicLinks.buildShortLink(parameters);
    url = shortLink.shortUrl;
    return url.toString();
  }
}
