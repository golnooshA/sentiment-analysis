import 'dart:convert';

class TokenizerUtils {
  final Map<String, int> wordIndex;
  final String oovToken;

  TokenizerUtils({required this.wordIndex, required this.oovToken});

  factory TokenizerUtils.fromJson(Map<String, dynamic> json) {
    final config = json['config'];

    // Decode the stringified word_index
    final wordIndexRaw = config['word_index'];
    final decodedWordIndex = jsonDecode(wordIndexRaw);

    // 🔍 Debug line – prints first few words from tokenizer
    print('✅ Decoded wordIndex keys: ${decodedWordIndex.keys.take(5).toList()}');

    return TokenizerUtils(
      wordIndex: Map<String, int>.from(decodedWordIndex),
      oovToken: config['oov_token'],
    );
  }


  List<int> textToSequence(String text) {
    final words = text.toLowerCase().split(RegExp(r'\s+')); // ✅ CORRECT ESCAPE
    return words.map((word) => wordIndex[word] ?? wordIndex[oovToken] ?? 1).toList();
  }

  List<int> padSequence(List<int> sequence, int maxLen) {
    if (sequence.length > maxLen) {
      return sequence.sublist(0, maxLen);
    } else {
      return sequence + List.filled(maxLen - sequence.length, 0);
    }
  }

  List<double> process(String text, int maxLen) {
    final sequence = textToSequence(text);
    final padded = padSequence(sequence, maxLen);
    return padded.map((e) => e.toDouble()).toList();
  }
}
