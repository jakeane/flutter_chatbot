import 'package:flutter/material.dart';
import 'package:flutter_chatbot/assets/assets.dart';

class TextComposer extends StatelessWidget {
  TextComposer({this.focusNode, this.handleSubmit, this.controller});

  final FocusNode focusNode;
  final Function(String) handleSubmit;
  final TextEditingController controller;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        color: Theme.of(context).backgroundColor,
        child: Container(
          padding: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.only(bottom: 15, top: 15),
                      child: TextField(
                        controller: controller,
                        autofocus: true,
                        focusNode: focusNode,
                        style: Theme.of(context).textTheme.caption,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 15,
                        onSubmitted: (value) {
                          handleSubmit(value);
                        },
                        decoration: InputDecoration.collapsed(
                          hintText: "Type message here",
                        ),
                      ))),
              IconButton(
                icon: Icon(Cb.send),
                iconSize: 25.0,
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  handleSubmit(controller.text);
                },
              )
            ],
          ),
        ));
  }
}
