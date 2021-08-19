import 'package:flutter/material.dart';
import 'package:pixelegram/domain/model/tdapi.dart' as td;
import 'package:pixelegram/infrastructure/util/util.dart';

class ItemContentPoll extends StatelessWidget {
  final td.MessagePoll poll;

  const ItemContentPoll({Key? key, required this.poll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int voteCount = poll.poll?.totalVoterCount ?? 0;
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: ConstraintSize.maxWidth(context),
          maxWidth: ConstraintSize.maxWidth(context)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.blue.withAlpha(128),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${poll.poll?.question ?? ''}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text('${poll.poll?.isAnonymous ?? false ? 'Anonymous ' : ''}Poll',
                  style: TextStyle(color: Colors.white.withAlpha(180))),
              ListView.separated(
                separatorBuilder: (_, __) {
                  return Divider();
                },
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  td.PollOption option = poll.poll!.options![index];
                  return PollItem(option: option);
                },
                shrinkWrap: true,
                itemCount: poll.poll?.options?.length ?? 0,
              ),
              Text('$voteCount vote${voteCount==1?'':'s'}',style: TextStyle(
                fontSize: 15,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

class PollItem extends StatefulWidget {
  final td.PollOption option;
  const PollItem({Key? key, required this.option}) : super(key: key);

  @override
  _PollItemState createState() => _PollItemState();
}

class _PollItemState extends State<PollItem> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          select = !select;
        });
      },
      contentPadding: EdgeInsets.zero,
      leading: Transform.scale(
        scale: 1.25,
        child: Checkbox(
            shape: CircleBorder(),
            value: select,
            onChanged: (newValue) {
              select = !select;
            }),
      ),
      title: Text(
        '${widget.option.text ?? ''}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      dense: true,
    );
  }
}
