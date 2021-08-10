import 'package:flutter/material.dart';
import 'package:pixelegram/infrastructure/tdapi.dart' as td;
import 'package:pixelegram/presentation/chat/list_tile/content/message_content_video.dart';
import 'package:pixelegram/presentation/chat/list_tile/content/message_content_voice_note.dart';
import 'content/content.dart';

/// * MessageExpiredPhoto
/// * MessageExpiredVideo
/// * MessageVenue
/// * MessageContact
/// * MessageDice
/// * MessageGame
/// * MessageInvoice
/// * MessageCall
/// * MessageVoiceChatStarted
/// * MessageVoiceChatEnded
/// * MessageInviteVoiceChatParticipants
/// * MessageBasicGroupChatCreate
/// * MessageSupergroupChatCreate
/// * MessageChatChangeTitle
/// * MessageChatChangePhoto
/// * MessageChatDeletePhoto
/// * MessageChatAddMembers
/// * MessageChatJoinByLink
/// * MessageChatDeleteMember
/// * MessageChatUpgradeTo
/// * MessageChatUpgradeFrom
/// * MessagePinMessage
/// * MessageScreenshotTaken
/// * MessageChatSetTtl
/// * MessageCustomServiceAction
/// * MessageGameScore
/// * MessagePaymentSuccessful
/// * MessagePaymentSuccessfulBot
/// * MessageContactRegistered
/// * MessageWebsiteConnected
/// * MessagePassportDataSent
/// * MessagePassportDataReceived
/// * MessageProximityAlertTriggered
/// * MessageUnsupported

class ListTileMessageContent extends StatelessWidget {
  final td.Message? message;
  final td.ChatType chatType;

  const ListTileMessageContent({Key? key, this.message, required this.chatType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
      child: _ListTileMessageContent(
        message: message,
        chatType: chatType,
      ),
    );
  }
}

class _ListTileMessageContent extends StatelessWidget {
  final td.Message? message;
  final td.ChatType chatType;

  const _ListTileMessageContent(
      {Key? key, this.message, required this.chatType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    td.MessageContent? content = message?.content;
    if (content is td.MessageText) {
      return MessageContentText(
        text: content,
        chatType: chatType,
      );
    } else if (content is td.MessageAnimation) {
      return MessageContentAnimation(
        animation: content,
      );
    } else if (content is td.MessageAudio) {
      return MessageContentAudio(
        audio: content,
      );
    } else if (content is td.MessageDocument) {
      return MessageContentDocument(
        document: content,
      );
    } else if (content is td.MessagePhoto) {
      return MessageContentPhoto(
        photo: content,
      );
    } else if (content is td.MessageExpiredPhoto) {
    } else if (content is td.MessageSticker) {
      return MessageContentSticker(
        sticker: content,
      );
    } else if (content is td.MessageVideo) {
      return MessageContentVideo(
        video: content,
      );
    } else if (content is td.MessageExpiredVideo) {
    } else if (content is td.MessageVideoNote) {
      return MessageContentVideoNote(
        videoNote: content,
      );
    } else if (content is td.MessageVoiceNote) {
      return MessageContentVoiceNote(
        voiceNote: content,
      );
    } else if (content is td.MessageLocation) {
      return MessageContentLocation(
        location: content,
      );
    } else if (content is td.MessageVenue) {
    } else if (content is td.MessageContact) {
      return MessageContentContact(
        contact: content,
      );
    } else if (content is td.MessageDice) {
    } else if (content is td.MessageGame) {
      return MessageContentGame(game: content);
    } else if (content is td.MessagePoll) {
      return MessageContentPoll(
        poll: content,
      );
    } else if (content is td.MessageInvoice) {
    } else if (content is td.MessageCall) {
      return MessageContentCall(
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
