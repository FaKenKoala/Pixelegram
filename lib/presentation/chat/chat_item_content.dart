import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;
import 'package:pixelegram/presentation/chat/widgets/sender_avatar.dart';
import 'package:pixelegram/presentation/custom_widget/custom_widget.dart';
import 'content/content.dart';

class ChatItemContent extends StatelessWidget {
  final td.Message? message;

  const ChatItemContent({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SenderAvatar(sender: message?.sender),
            SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  _ChatItemContent(
                    message: message,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Opacity(
              opacity: 0.0,
              child: SenderAvatar(sender: message?.sender)),
          ],
        ),
      ),
    );
  }
}

class _ChatItemContent extends StatelessWidget {
  final td.Message? message;

  const _ChatItemContent({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    td.MessageContent? content = message?.content;
    if (content is td.MessageText) {
      return ItemContentText(
        text: content,
      );
    } else if (content is td.MessageAnimation) {
      return ItemContentAnimation(
        animation: content,
      );
    } else if (content is td.MessageAudio) {
      return ItemContentAudio(
        audio: content,
      );
    } else if (content is td.MessageDocument) {
      return ItemContentDocument(
        document: content,
      );
    } else if (content is td.MessagePhoto) {
      return ItemContentPhoto(
        photo: content,
      );
    } else if (content is td.MessageExpiredPhoto) {
    } else if (content is td.MessageSticker) {
      return ItemContentSticker(
        sticker: content,
      );
    } else if (content is td.MessageVideo) {
      return ItemContentVideo(
        video: content,
      );
    } else if (content is td.MessageExpiredVideo) {
    } else if (content is td.MessageVideoNote) {
      return ItemContentVideoNote(
        videoNote: content,
      );
    } else if (content is td.MessageVoiceNote) {
      return ItemContentVoiceNote(
        voiceNote: content,
      );
    } else if (content is td.MessageLocation) {
      return ItemContentLocation(
        location: content,
      );
    } else if (content is td.MessageVenue) {
    } else if (content is td.MessageContact) {
      return ItemContentContact(
        contact: content,
      );
    } else if (content is td.MessageDice) {
    } else if (content is td.MessageGame) {
      return ItemContentGame(game: content);
    } else if (content is td.MessagePoll) {
      return ItemContentPoll(
        poll: content,
      );
    } else if (content is td.MessageInvoice) {
    } else if (content is td.MessageCall) {
      return ItemContentCall(
        call: content,
      );
    } else if (content is td.MessageVoiceChatStarted) {
    } else if (content is td.MessageVoiceChatEnded) {
    } else if (content is td.MessageInviteVoiceChatParticipants) {
    } else if (content is td.MessageBasicGroupChatCreate) {
    } else if (content is td.MessageSupergroupChatCreate) {
    } else if (content is td.MessageChatChangeTitle) {
    } else if (content is td.MessageChatChangePhoto) {
    } else if (content is td.MessageChatDeletePhoto) {
    } else if (content is td.MessageChatAddMembers) {
    } else if (content is td.MessageChatJoinByLink) {
    } else if (content is td.MessageChatDeleteMember) {
    } else if (content is td.MessageChatUpgradeTo) {
    } else if (content is td.MessageChatUpgradeFrom) {
    } else if (content is td.MessagePinMessage) {
    } else if (content is td.MessageScreenshotTaken) {
    } else if (content is td.MessageChatSetTtl) {
    } else if (content is td.MessageCustomServiceAction) {
    } else if (content is td.MessageGameScore) {
    } else if (content is td.MessagePaymentSuccessful) {
    } else if (content is td.MessagePaymentSuccessfulBot) {
    } else if (content is td.MessageContactRegistered) {
    } else if (content is td.MessageWebsiteConnected) {
    } else if (content is td.MessagePassportDataSent) {
    } else if (content is td.MessagePassportDataReceived) {
    } else if (content is td.MessageProximityAlertTriggered) {
    } else if (content is td.MessageUnsupported) {}
    return Container();
  }
}
