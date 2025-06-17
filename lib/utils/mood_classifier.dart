import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'tokenizer_utils.dart';

class MoodClassifier {
  Interpreter? _interpreter;
  TokenizerUtils? _tokenizer;
  final int maxLen;

  MoodClassifier({this.maxLen = 10});

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/model/sentiment_model.tflite');
    final tokenizerJson = await rootBundle.loadString('assets/model/tokenizer.json');
    _tokenizer = TokenizerUtils.fromJson(jsonDecode(tokenizerJson));
  }

  Future<String> predictSentiment(String text) async {
    if (_interpreter == null || _tokenizer == null) {
      throw Exception("Model or tokenizer not loaded.");
    }

    final input = [_tokenizer!.process(text, maxLen)];
    final output = List.filled(3, 0.0).reshape([1, 3]);

    _interpreter!.run(input, output);
    final probs = List<double>.from(output[0]);
    final maxVal = probs.reduce(max);
    final index = probs.indexOf(maxVal);
    return ['Negative', 'Neutral', 'Positive'][index];
  }

  void dispose() {
    _interpreter?.close();
  }
}
