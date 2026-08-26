import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class OtpFields extends StatefulWidget {
  final int length;
  final Function(String)? onCompleted;
  final VoidCallback? onError;

  const OtpFields({super.key, this.length = 6, this.onCompleted, this.onError});

  @override
  State<OtpFields> createState() => OtpFieldsState();
}

class OtpFieldsState extends State<OtpFields> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late List<FocusNode> _keyboardFocusNodes;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(widget.length, (_) => TextEditingController());

    _focusNodes = List.generate(widget.length, (_) => FocusNode());

    /// مهم علشان نسمع زرار الكيبورد
    _keyboardFocusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focus in _focusNodes) {
      focus.dispose();
    }

    for (final focus in _keyboardFocusNodes) {
      focus.dispose();
    }

    super.dispose();
  }

  void _onChanged(String value, int index) {
    /// يتحرك لقدام
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    final otp = _controllers.map((e) => e.text).join();

    if (otp.length == widget.length) {
      widget.onCompleted?.call(otp);
    }
  }

  void _onKeyPressed(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        /// يرجع للخانة اللي قبلها
        _focusNodes[index - 1].requestFocus();

        /// يمسحها كمان
        _controllers[index - 1].clear();
      }
    }
  }

  void clearOtp() {
    for (final controller in _controllers) {
      controller.clear();
    }

    _focusNodes.first.requestFocus();

    widget.onError?.call();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.length, (index) {
          return Container(
            width: 48,
            height: 58,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: RawKeyboardListener(
              focusNode: _keyboardFocusNodes[index],
              onKey: (event) => _onKeyPressed(event, index),
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                cursorColor: ColorsManager.primaryColor,
                decoration: const InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: ColorsManager.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) => _onChanged(value, index),
              ),
            ),
          );
        }),
      ),
    );
  }
}
