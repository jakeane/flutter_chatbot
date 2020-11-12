import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/chatbot/shake_container.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/active_feedback_icon.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/message/decorated_bubble.dart';

// Parent: ResponseContainer
class BotResponse extends StatelessWidget {
  BotResponse(
      {this.setFeedbackView,
      this.text,
      this.feedback,
      this.bubbleColor,
      this.textStyle});
  final Function(int) setFeedbackView;
  final String text;
  final int feedback;
  final Color bubbleColor;
  final TextStyle textStyle;

  final List<String> suppressFeedbackText = [
    "Hold on, I'm thinking...",
    "Hi! I am TheraBot. I am here to talk to you about any mental health problems you might be having."
  ];

  Widget build(BuildContext context) {
    bool suppressFeedback = suppressFeedbackText.contains(text);

    return Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBubble(
              text: text,
              maxWidth: MediaQuery.of(context).size.width - 180,
              feedback: feedback,
              feedbackIcon: ActiveFeedbackIcon(feedback: feedback),
            ),
            feedback != -1 || suppressFeedback
                ? Container(
                    height: 48, color: Theme.of(context).backgroundColor)
                : ShakeContainer(
                    setFeedbackView: setFeedbackView,
                  )
          ],
        ));
  }
}
