import 'dart:async';

import 'package:acm_open_ai_flutter/acm_open_ai_sdk.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? answer;
  final chatGpt =
      ACMOpenAI.instance.init(token: 'sk-', isLog: true);
  bool loading = false;
   String prompt = 'Hello';

  final List<Map<String, String>> questionAnswers = [];

  late TextEditingController textEditingController;

  StreamSubscription<ACMOpenAIChatCompleteResponse>? streamSubscription;

  @override
  void initState() {
    textEditingController = TextEditingController(text: prompt);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ACMChatGPT")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: questionAnswers.length,
                  itemBuilder: (context, index) {
                    final answer = questionAnswers[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Q: ${answer['q']}'),
                        const SizedBox(height: 12),
                        if (answer.isEmpty && loading)
                          const Center(child: CircularProgressIndicator())
                        else
                          Text('A: ${answer['a'].toString().trim()}'),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: const InputDecoration(hintText: 'Type in...'),
                      onFieldSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ClipOval(
                    child: Material(
                      color: Colors.blue, // Button color
                      child: InkWell(
                        onTap: _sendMessage,
                        child: const SizedBox(
                          width: 48,
                          height: 48,
                          child: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendMessage() async {
    prompt=textEditingController.text;
    questionAnswers.add({'q': prompt, 'a': ''});
    setState(() {
      textEditingController.clear();
      loading = true;
    });
    final testRequest = ACMOpenAIChatCompleteTextRequest(
      kChatGptTurboModel,
      [
        {"role": "user", "content": prompt}
      ],
      stream: true,
      maxToken: 4000,
    );
    await _streamResponse(testRequest);
    setState(() => loading = false);
  }

  _streamResponse(ACMOpenAIChatCompleteTextRequest request) {
    streamSubscription?.cancel();
    String tempString = '';
    try {
      final stream = chatGpt.chat.createSSE(request);
      streamSubscription = stream.listen((event) {
        tempString += event.choices.first.message?.content ?? '';
        print(tempString);
        setState(() {
          questionAnswers.where((element) => element['q'] == prompt).first['a'] =
              tempString;
        });
      });
      print(questionAnswers);
    } catch (error) {
      setState(() {
        loading = false;
      });
      print("Error occurred: $error");
    }
  }
}
