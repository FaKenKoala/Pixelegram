import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;

class ItemContentGame extends StatelessWidget {
  final td.MessageGame game;

  const ItemContentGame({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.videogame_asset,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
            child: Text(
          'Invited you to play ${game.game?.title ?? ''}',
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }
}
