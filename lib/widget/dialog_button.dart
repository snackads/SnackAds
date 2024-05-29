import 'package:flutter/material.dart';

enum DialogType {
  alert,
  confirm,
  input,
}

class DialogButton extends StatelessWidget {
  DialogButton({
    super.key,
    required this.title,
    required this.content,
    this.cancelButtonText,
    required this.confirmButtonText,
    this.onCancelAction,
    required this.onConfirmAction,
  });

  String title;
  String content;
  String? cancelButtonText;
  String confirmButtonText;
  void Function()? onCancelAction;
  void Function() onConfirmAction;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.orange[100],
      child: SizedBox(
        width: 300,
        height: 200,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                content,
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cancel
                  cancelButtonText != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: ElevatedButton(
                            onPressed: onCancelAction,
                            child: Text(cancelButtonText!),
                          ),
                        )
                      : const SizedBox(),

                  // Confirm
                  ElevatedButton(
                    onPressed: onConfirmAction,
                    child: Text(confirmButtonText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
