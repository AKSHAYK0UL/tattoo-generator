import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import "package:http/http.dart" as http;
import 'package:artbot/secrets/apikey.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gimage_event.dart';
part 'gimage_state.dart';

class GimageBloc extends Bloc<GimageEvent, GimageState> {
  GimageBloc() : super(GimageInitial()) {
    on<SetToGintitailState>(_setgintial);
    on<GenerateQuotes>(_generateQuotes);
    on<OnPressedGenerateImageEvent>(_onpressedgenerate);
  }
  void _setgintial(SetToGintitailState event, Emitter<GimageState> emit) {
    emit(GimageInitial());
    return;
  }

  Future<void> _generateQuotes(
      GenerateQuotes event, Emitter<GimageState> emit) async {
    emit(LoadingState());
    try {
      final response =
          await http.get(Uri.parse('https://zenquotes.io/api/quotes/'));

      List jsonResponse = json.decode(response.body);
      String q = jsonResponse[0]['q'];
      String a = jsonResponse[0]['a'];

      print(q);
      print(a);
      emit(
        GimageInitial(Quote: q, auth: a),
      );
      return;
    } catch (e) {
      emit(FailureState("Something went wrong"));
      return;
    }
  }

  Future<void> _onpressedgenerate(
      OnPressedGenerateImageEvent event, Emitter<GimageState> emit) async {
    emit(LoadingState());
    final url = Uri.parse('https://api.edenai.run/v2/image/generation');

    List<String> generatedImages = [];
    try {
      final model =
          GenerativeModel(model: 'gemini-1.5-flash', apiKey: geminiApikey);
      final content = [
        Content.text(
            '${event.prompt} ? is this asking for tattoo kind of stuff ? if yes then give yes in response or else give no your response should be only in these 2 type.')
      ];
      final geminiresponse = await model.generateContent(content);

      // print();
      if (geminiresponse.text!.contains("no") ||
          geminiresponse.text!.contains("no.") ||
          geminiresponse.text!.contains("No") ||
          geminiresponse.text!.contains("No.") ||
          geminiresponse.text!.contains("NO") ||
          geminiresponse.text!.contains("NO.")) {
        print("INSIDE IF");
        emit(FailureState("This app can only generate tattoos"));
        return;
      }
      for (var i = 0; i < 5; i++) {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            "response_as_dict": true,
            "attributes_as_list": true,
            "show_original_response": true,
            "num_images": 1,
            "providers": "replicate",
            "text":
                '${event.prompt} whatever the prompt is asking try to convert it into a meaningful and realistic tattoo',
            "resolution": "512x512"
          }),
        );
        print('BODY : ${response.body}');
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          // print(jsonResponse);
          // print("IMAGE URL :${jsonResponse['replicate']}");
          // print(
          //     "IMAGE URL :${jsonResponse['replicate']['original_response']['output']}");
          final data = jsonResponse['replicate']['original_response']['output'];
          print("URL : $data");
          generatedImages.add(data);
        }
      }
      emit(ImageGenerateState(generatedImages));
      return;
    } catch (_) {
      emit(FailureState("Something went wrong"));
      return;
    }
  }
}
