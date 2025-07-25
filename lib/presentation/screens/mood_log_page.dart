import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../core/config/design_config.dart';
import '../../models/mood_log.dart';
import '../../utils/mood_classifier.dart';
import '../widgets/app_bar.dart';
import '../widgets/mood_input_field.dart';
import '../widgets/mood_save_button.dart';

class MoodLogPage extends StatefulWidget {
  const MoodLogPage({super.key});

  @override
  State<MoodLogPage> createState() => _MoodLogPageState();
}

class _MoodLogPageState extends State<MoodLogPage> {
  final TextEditingController _moodController = TextEditingController();
  final MoodClassifier _classifier = MoodClassifier();
  bool _isModelReady = false;

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  Future<void> _initModel() async {
    try {
      await _classifier.loadModel();
      setState(() => _isModelReady = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Model loaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error loading model: $e')),
      );
    }
  }

  Future<void> _handleSaveMood() async {
    final text = _moodController.text.trim();
    if (text.isEmpty || !_isModelReady) return;

    try {
      final sentiment = await _classifier.predictSentiment(text);
      final box = await Hive.openBox<MoodLog>('mood_logs');
      await box.add(MoodLog(
        moodText: text,
        sentiment: sentiment,
        timestamp: DateTime.now(),
      ));

      _moodController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Saved mood as: $sentiment')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Prediction failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDesign(title: 'Mood Log'),
      backgroundColor: DesignConfig.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MoodInputField(controller: _moodController),
            const SizedBox(height: 16),
            MoodSaveButton(onPressed: _handleSaveMood),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _moodController.dispose();
    _classifier.dispose();
    super.dispose();
  }
}
