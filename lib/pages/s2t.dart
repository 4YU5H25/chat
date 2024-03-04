import 'dart:async';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  static SpeechToText? speechToText = SpeechToText();
  static String lastWords = '';
  static bool speechEnabled = false;

  static Future<void> initSpeech() async {
    speechEnabled = await speechToText!.initialize();
    print("s2t initialised!");
  }

  /// Each time to start a speech recognition session
  static Future<void> startListening() async {
    print("listening");
    await speechToText!.listen(onResult: onSpeechResult);
    print("listened");
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  static String onSpeechResult(SpeechRecognitionResult result) {
    lastWords = result.recognizedWords;
    print("last words: $lastWords");
    return result.recognizedWords;
  }

  static Future<void> stopListening() async {
    if (speechToText != null && speechToText!.isListening) {
      await speechToText!.stop();
    }
  }

  static Future<void> cancelListening() async {
    if (speechToText! != null && speechToText!.isListening) {
      await speechToText!.cancel();
    }
  }

  static Future<void> destroySpeechRecognizer() async {
    if (speechToText! != null) {
      await speechToText!.cancel();
      speechToText = null;
    }
  }
}
