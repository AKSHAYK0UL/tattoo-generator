import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ImagePreviewScreen extends StatelessWidget {
  static const routeName = "ImagePreviewScreen";
  const ImagePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Imageurl = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 53, 53, 91),
      // appBar: AppBar(
      //   automaticallyImplyLeading: !Platform.isAndroid ? true : false,
      //   backgroundColor: const Color.fromARGB(0, 53, 53, 91),
      //   title: const Text(
      //     "Generate",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 25,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       padding: EdgeInsets.zero,
      //       onPressed: () {},
      //       icon: const Icon(
      //         Icons.download,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ],
      // ),
      body: Center(
        child: WidgetZoom(
          closeFullScreenImageOnDispose: true,
          heroAnimationTag: 'tag',
          zoomWidget: Image.network(
            Imageurl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
