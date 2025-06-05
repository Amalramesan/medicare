import 'package:flutter/material.dart';

class DialogButtons extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSubmit;

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
        ElevatedButton(onPressed: onSubmit, child: const Text("Submit")),
      ],
    );
  }
}
