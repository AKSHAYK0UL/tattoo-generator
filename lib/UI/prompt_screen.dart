import 'package:artbot/UI/generated_images_screen.dart';
import 'package:artbot/UI/setting_screen.dart';
import 'package:artbot/bloc/gimage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  Future<void> _onpressgenerate(BuildContext context) async {
    if (_promptController.text.trim().isNotEmpty) {
      FocusManager.instance.primaryFocus!.unfocus();

      context.read<GimageBloc>().add(
            OnPressedGenerateImageEvent(
              prompt: _promptController.text,
              imageCount: 1,
            ),
          );
      _promptController.clear();
    }
  }

  final _promptController = TextEditingController();
  @override
  void initState() {
    context.read<GimageBloc>().add(GenerateQuotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 53, 53, 91),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 53, 53, 91),
          title: const Text(
            "Tattoo Generator",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(
                Icons.info,
                color: Colors.white,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pushNamed(SettingScreen.routeName);
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.012,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    hintText: 'Enter your prompt',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Colors.white60, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Colors.white60, width: 2),
                    ),
                    hintStyle: const TextStyle(
                        height: 2, fontSize: 15, color: Colors.white),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  maxLines: 3,
                  controller: _promptController,
                  textInputAction: TextInputAction.newline,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.010,
              ),
              BlocConsumer<GimageBloc, GimageState>(
                listener: (context, state) {
                  if (state is ImageGenerateState) {
                    Navigator.of(context).pushNamed(ImagesScreen.routeName);
                  }
                },
                builder: (context, state) {
                  print(state);
                  if (state is GimageInitial) {
                    print(state.Quote);

                    return SizedBox(
                      height: screenSize.height * 0.63,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              child: Text(
                                state.Quote,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              "By: '${state.auth}'",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is LoadingState) {
                    return SizedBox(
                      height: screenSize.height * 0.63,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Loading Please wait...',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is FailureState) {
                    return SizedBox(
                      height: screenSize.height * 0.63,
                      child: Center(
                        child: Text(
                          state.error,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(left: screenSize.width * 0.078),
          child: SizedBox(
            width: double.infinity,
            height: screenSize.height * 0.062,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                _onpressgenerate(
                  context,
                );
              },
              icon: const Icon(Icons.generating_tokens_sharp,
                  color: Colors.black),
              label: const Text(
                "Generate",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
