import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomEditableText extends StatefulWidget {
  final TextStyle textStyle;
  final String title;
  final String text;
  final bool multiline;
  final TextAlign textAlign;
  final bool verified;
  final Function(String) onSubmited;

  const CustomEditableText(
      {Key key,
      this.textStyle,
      this.text = '',
      this.title = 'Edit',
      this.multiline = false,
      this.textAlign = TextAlign.start,
      this.onSubmited,
      this.verified})
      : super(key: key);

  @override
  _CustomEditableTextState createState() => _CustomEditableTextState();
}

class _CustomEditableTextState extends State<CustomEditableText> {
  String text;
  bool verified;
  TextEditingController textController = new TextEditingController();

  void editText() async {
    final result = await showDialog<String>(
        context: context,
        builder: (context) =>  StatefulBuilder(
            builder: (context, dialogSetState){
            return AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.clear,
                        color: Colors.transparent,
                      ),
                      Text(
                        widget.title,
                        style: MyTextStyles.titleBold.apply(color: Colors.black),
                      ),
                      InkWell(
                        child: InkWell(
                          child: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: MyColors.greyLight,
                                  borderRadius: BorderRadius.circular(
                                      widget.multiline ? 20.0 : 100.0),
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: textController,
                                    maxLines: widget.multiline ? 5 : 1,
                                    keyboardType: widget.multiline
                                        ? TextInputType.multiline
                                        : TextInputType.text,
                                    style: MyTextStyles.fbText,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: text,
                                      hintStyle: TextStyle(color: Colors.grey),
                                      suffix: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100.0),
                                          color: Colors.black,
                                        ),
                                        child: InkWell(
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                            size: 10.0,
                                          ),
                                          onTap: () => textController.clear(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            widget.verified != null ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, left: 8.0, bottom: 2.0),
                                  child: Text(
                                    'Verified',
                                    style: TextStyle(color: MyColors.accent),
                                  ),
                                ),
                                IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/verified_badge.svg',
                                    width: 30.0,
                                    color: verified
                                        ? MyColors.accent
                                        : MyColors.greyLight,
                                  ),
                                  onPressed: () {
                                    verified = !verified;
                                    setState(() {});
                                    dialogSetState(() {});
                                  },
                                ),
                              ],
                            ) : SizedBox(),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        margin: EdgeInsets.only(top: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: Colors.black,
                        ),
                        child: InkWell(
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          onTap: () {
                            if (widget.onSubmited != null) {
                              setState(() {
                                widget.onSubmited(textController.text);
                              });
                            }
                            Navigator.pop(context, textController.text);
                          },
                        ),
                      ),
                    ],
                  ),
                );
          }
        ));

    if (result != null && result != '') {
//      if (mounted) {
      if (!mounted) return;
      setState(() => text = result);
//      } else {
//        print('Not mounted yet');
//      }
    }
  }

  @override
  void initState() {
    super.initState();
    text = widget.text;
    verified = widget.verified ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        editText();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: widget.textStyle,
            textAlign: widget.textAlign,
            overflow: TextOverflow.ellipsis,
            maxLines: 7,
          ),
          verified != null && verified
              ? Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: SvgPicture.asset(
                    'assets/icons/verified_badge.svg',
                    width: 12.0,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
