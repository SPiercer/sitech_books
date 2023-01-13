import 'package:flutter/material.dart';

class MaterialYouDialog extends Dialog {
  const MaterialYouDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/material-you.png'),
            const Text(
              "This app uses Material3 (You) theme",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "You can toggle the dynamic theme feature (android 12+ only) from the toggle button in the app bar.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
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
