import 'package:flutter/material.dart';
import 'dart:async';

class FormWithSubmitTrigger extends StatefulWidget {
  const FormWithSubmitTrigger({Key? key, @required this.submitTrigger})
      : super(key: key);

  final Stream? submitTrigger;

  @override
  State<StatefulWidget> createState() => FormWithSubmitTriggerState();
}

class FormWithSubmitTriggerState<T extends FormWithSubmitTrigger>
    extends State<T> {
  late StreamSubscription? streamSubscription;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    streamSubscription = widget.submitTrigger?.listen((_) => checkAndSubmit());
  }

  @override
  didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.submitTrigger != oldWidget.submitTrigger) {
      streamSubscription?.cancel();
      streamSubscription =
          widget.submitTrigger?.listen((_) => checkAndSubmit());
    }
  }

  @override
  dispose() {
    super.dispose();

    streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: const [],
        ));
  }

  void checkAndSubmit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      onSave();
    }
  }

  Future<void> onSave() async {}
}
