import 'package:flutter/material.dart';

/// Arguments passed via Navigator to the quiz screen.
class QuizArgs {
  final int testPaperId;
  final String title;

  const QuizArgs({required this.testPaperId, required this.title});
}

/// Placeholder quiz screen. The original `quiz_view.dart` was missing from the
/// repository, so this stub keeps the app compiling while preserving the route
/// surface (`QuizView`) and the argument shape (`QuizArgs`) that the rest of
/// the codebase already expects.
class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as QuizArgs?;
    return Scaffold(
      appBar: AppBar(title: Text(args?.title ?? 'Quiz')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            args == null
                ? 'Quiz screen placeholder.'
                : 'Quiz placeholder\nTest paper ID: ${args.testPaperId}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
