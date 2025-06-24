import 'package:flutter/material.dart';

class DialogButtons extends StatelessWidget {
  final VoidCallback onClose;
  final Future<void> Function() onSubmit;

  const DialogButtons({
    super.key,
    required this.onClose,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: onClose, child: const Text("Close")),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () async {
            try {
              await onSubmit();
            } catch (e) {
              debugPrint('Error submitting upload form: $e');
              if(context.mounted){
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Something went wrong: $e")),
              );
              }
             
            }
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
