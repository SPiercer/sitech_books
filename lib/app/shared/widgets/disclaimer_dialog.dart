import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DisclaimerDialog extends Dialog {
  const DisclaimerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/disclaimer.json'),
            const Text(
              'This app is for demonstration purposes only. It is not intended for production use.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
