part of '../tdapi.dart';

class ChatActionBar extends TdObject {
  /// Describes actions which should be possible to do through a chat action bar
  ChatActionBar();

  /// a ChatActionBar return type can be :
  /// * ChatActionBarReportSpam
  /// * ChatActionBarReportUnrelatedLocation
  /// * ChatActionBarReportAddBlock
  /// * ChatActionBarAddContact
  /// * ChatActionBarSharePhoneNumber
  static ChatActionBar? fromJson(Map<String, dynamic> json) {
    switch (json["@type"]) {
      case ChatActionBarReportSpam.CONSTRUCTOR:
        return ChatActionBarReportSpam.fromJson(json);
      case ChatActionBarReportUnrelatedLocation.CONSTRUCTOR:
        return ChatActionBarReportUnrelatedLocation.fromJson(json);
      case ChatActionBarReportAddBlock.CONSTRUCTOR:
        return ChatActionBarReportAddBlock.fromJson(json);
      case ChatActionBarAddContact.CONSTRUCTOR:
        return ChatActionBarAddContact.fromJson(json);
      case ChatActionBarSharePhoneNumber.CONSTRUCTOR:
        return ChatActionBarSharePhoneNumber.fromJson(json);
      default:
        return null;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  static const CONSTRUCTOR = 'chatActionBar';

  @override
  String getConstructor() => CONSTRUCTOR;
}

class ChatActionBarReportSpam extends ChatActionBar {
  /// The chat can be reported as spam using the method reportChat with the reason chatReportReasonSpam
  ChatActionBarReportSpam({this.canUnarchive});

  /// [canUnarchive] If true, the chat was automatically archived and can be moved back to the main chat list using addChatToList simultaneously with setting chat notification settings to default using setChatNotificationSettings
  bool? canUnarchive;

  /// Parse from a json
  ChatActionBarReportSpam.fromJson(Map<String, dynamic> json) {
    this.canUnarchive = json['can_unarchive'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "@type": CONSTRUCTOR,
      "can_unarchive": this.canUnarchive,
    };
  }

  static const CONSTRUCTOR = 'chatActionBarReportSpam';

  @override
  String getConstructor() => CONSTRUCTOR;
}

class ChatActionBarReportUnrelatedLocation extends ChatActionBar {
  /// The chat is a location-based supergroup, which can be reported as having unrelated location using the method reportChat with the reason chatReportReasonUnrelatedLocation
  ChatActionBarReportUnrelatedLocation();

  /// Parse from a json
  ChatActionBarReportUnrelatedLocation.fromJson(Map<String, dynamic> json);

  @override
  Map<String, dynamic> toJson() {
    return {
      "@type": CONSTRUCTOR,
    };
  }

  static const CONSTRUCTOR = 'chatActionBarReportUnrelatedLocation';

  @override
  String getConstructor() => CONSTRUCTOR;
}

class ChatActionBarReportAddBlock extends ChatActionBar {
  /// The chat is a private or secret chat, which can be reported using the method reportChat, or the other user can be blocked using the method blockUser, or the other user can be added to the contact list using the method addContact
  ChatActionBarReportAddBlock({this.canUnarchive, this.distance});

  /// [canUnarchive] If true, the chat was automatically archived and can be moved back to the main chat list using addChatToList simultaneously with setting chat notification settings to default using setChatNotificationSettings
  bool? canUnarchive;

  /// [distance] If non-negative, the current user was found by the peer through searchChatsNearby and this is the distance between the users
  int? distance;

  /// Parse from a json
  ChatActionBarReportAddBlock.fromJson(Map<String, dynamic> json) {
    this.canUnarchive = json['can_unarchive'];
    this.distance = json['distance'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "@type": CONSTRUCTOR,
      "can_unarchive": this.canUnarchive,
      "distance": this.distance,
    };
  }

  static const CONSTRUCTOR = 'chatActionBarReportAddBlock';

  @override
  String getConstructor() => CONSTRUCTOR;
}

class ChatActionBarAddContact extends ChatActionBar {
  /// The chat is a private or secret chat and the other user can be added to the contact list using the method addContact
  ChatActionBarAddContact();

  /// Parse from a json
  ChatActionBarAddContact.fromJson(Map<String, dynamic> json);

  @override
  Map<String, dynamic> toJson() {
    return {
      "@type": CONSTRUCTOR,
    };
  }

  static const CONSTRUCTOR = 'chatActionBarAddContact';

  @override
  String getConstructor() => CONSTRUCTOR;
}

class ChatActionBarSharePhoneNumber extends ChatActionBar {
  /// The chat is a private or secret chat with a mutual contact and the user's phone number can be shared with the other user using the method sharePhoneNumber
  ChatActionBarSharePhoneNumber();

  /// Parse from a json
  ChatActionBarSharePhoneNumber.fromJson(Map<String, dynamic> json);

  @override
  Map<String, dynamic> toJson() {
    return {
      "@type": CONSTRUCTOR,
    };
  }

  static const CONSTRUCTOR = 'chatActionBarSharePhoneNumber';

  @override
  String getConstructor() => CONSTRUCTOR;
}
