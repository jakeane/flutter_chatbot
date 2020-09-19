import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/app/state/chat_state.dart';
import 'package:flutter_chatbot/assets/assets.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/chat_nip.dart';
import 'package:flutter_chatbot/ui/views/messaging/widgets/message_bubble.dart';
import 'package:provider/provider.dart';

class BotResponse extends StatelessWidget {
  BotResponse({this.text, this.feedback, this.bubbleColor, this.textStyle});
  final String text;
  final int feedback;
  final Color bubbleColor;
  final TextStyle textStyle;

  final bool comment = true;

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                MessageBubble(
                  text: text,
                  bubbleColor: Theme.of(context).colorScheme.primaryVariant,
                  textStyle: Theme.of(context).textTheme.bodyText2,
                  maxWidth: MediaQuery.of(context).size.width - 180,
                ),
                Positioned(
                  bottom: -5,
                  child: CustomPaint(
                    size: Size(20, 25),
                    painter: ChatNip(
                        nipHeight: 5,
                        color: Theme.of(context).colorScheme.primaryVariant,
                        isUser: false),
                  ),
                ),
                if (feedback != -1)
                  Positioned(
                      top: -5,
                      right: -5,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).backgroundColor,
                        ),
                      )),
                if (feedback != -1)
                  Positioned(
                      top: -20,
                      right: -20,
                      child: IconButton(
                          icon: feedback == 1
                              ? Icon(Cb.feedbackcheckpressed)
                              : Icon(Cb.feedbackexpressed),
                          iconSize: 25,
                          color: Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () {
                            Provider.of<ChatModel>(context, listen: false)
                                .giveFeedback(-1, -1);
                          })),
              ],
              overflow: Overflow.visible,
            ),
            feedback != -1
                ? comment
                    ? IconButton(
                        icon: Icon(Cb.feedbackcomment),
                        iconSize: 40,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          print('comment');
                          Provider.of<ChatState>(context, listen: false)
                              .changeFeedbackState();
                        },
                      )
                    : Container(width: 100, height: 100, color: Colors.red)
                : Row(
                    children: [
                      IconButton(
                        icon: Icon(Cb.feedbackcheck),
                        iconSize: 40,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          print('check');
                          Provider.of<ChatModel>(context, listen: false)
                              .giveFeedback(-1, 1);
                        },
                      ),
                      IconButton(
                        icon: Icon(Cb.feedbackex),
                        iconSize: 40,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          print('ecks');
                          Provider.of<ChatModel>(context, listen: false)
                              .giveFeedback(-1, 0);
                        },
                      )
                    ],
                  )
          ],
        ));
  }
}
