import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../models/mood_log.dart';
import '../utils/tokenizer_utils.dart';

class MoodLogPage extends StatefulWidget {
  const MoodLogPage({super.key});

  @override
  State<MoodLogPage> createState() => _MoodLogPageState();
}

class _MoodLogPageState extends State<MoodLogPage> {
  final TextEditingController _moodController = TextEditingController();
  Interpreter? _interpreter;
  TokenizerUtils? _tokenizer;
  bool _modelLoaded = false;
  final int maxLen = 10;

  @override
  void initState() {
    super.initState();
    _loadModelAndTokenizer();
  }

  Future<void> _loadModelAndTokenizer() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model/sentiment_model.tflite');

      final tokenizerData = await rootBundle.loadString('assets/model/tokenizer.json');
      final Map<String, dynamic> decoded = jsonDecode(tokenizerData);
      _tokenizer = TokenizerUtils.fromJson(decoded);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Model and tokenizer loaded successfully')),
      );

      setState(() => _modelLoaded = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to load model or tokenizer: $e')),
      );
      debugPrint('Failed to load model or tokenizer: $e');
    }
  }

  Future<void> _handleSaveMood() async {
    final text = _moodController.text.trim();
    if (text.isEmpty || _interpreter == null || _tokenizer == null) return;

    final input = _tokenizer!.process(text, maxLen); // List<double>
    final inputTensor = [input];
    var output = List.filled(3, 0.0).reshape([1, 3]);

    _interpreter!.run(inputTensor, output);

    final List<double> predictions = List<double>.from(output[0]);
    double maxValue = predictions.reduce((a, b) => a > b ? a : b);
    int predicted = predictions.indexOf(maxValue);
    String moodLabel = ['Negative', 'Neutral', 'Positive'][predicted];

    var moodLogBox = await Hive.openBox<MoodLog>('mood_logs');
    moodLogBox.add(
      MoodLog(
        moodText: text,
        sentiment: moodLabel,
        timestamp: DateTime.now(),
      ),
    );

    _moodController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ Mood: $moodLabel (Confidence: ${maxValue.toStringAsFixed(2)})')),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Log')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _moodController,
              decoration: const InputDecoration(
                labelText: 'How are you feeling today?',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleSaveMood,
              child: const Text('Save Mood'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _moodController.dispose();
    _interpreter?.close();
    super.dispose();
  }
}
