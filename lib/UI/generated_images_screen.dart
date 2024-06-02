import 'dart:io';

import 'package:artbot/UI/image_preview_screen.dart';
import 'package:artbot/bloc/gimage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ImagesScreen extends StatelessWidget {
  static const routeName = 'ImagesScreen';
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 53, 53, 91),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 53, 53, 91),
          title: const Text(
            "Tattoo Images",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          automaticallyImplyLeading: !Platform.isAndroid ? true : false,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: BlocBuilder<GimageBloc, GimageState>(
            builder: (context, state) {
              if (state is ImageGenerateState) {
                return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          indent: 10,
                          endIndent: 10,
                          color: Colors.white,
                          thickness: 1,
                        ),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.images.length,
                    itemBuilder: (BuildContext context, int index) {
                      final imageurl = state.images[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  ImagePreviewScreen.routeName,
                                  arguments: imageurl);
                            },
                            child: WidgetZoom(
                              heroAnimationTag: imageurl,
                              // tag: imageurl,
                              zoomWidget: Image.network(
                                imageurl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
              return Container();
            },
          ),
        ),
      ),
      onPopInvoked: (didPop) {
        context.read<GimageBloc>().add(SetToGintitailState());
        context.read<GimageBloc>().add(GenerateQuotes());
      },
    );
  }
}
