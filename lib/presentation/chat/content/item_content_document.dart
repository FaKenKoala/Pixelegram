import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;
import 'package:pixelegram/infrastructure/util/util.dart';

class ItemContentDocument extends StatelessWidget {
  final td.MessageDocument document;

  const ItemContentDocument({Key? key, required this.document})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text = document.caption?.text;
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - (10 + 40 + 8) * 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.blue.withAlpha(128),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.insert_drive_file,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${document.document?.fileName ?? ''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          formatBytes(bytes :document.document?.document?.size ?? 0, splitter: ''),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: text?.isNotEmpty??false,
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Text('${text??''}'),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
