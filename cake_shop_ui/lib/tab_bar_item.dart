import 'package:flutter/material.dart';
import 'constants.dart';

class TabBarItem extends StatefulWidget {

  String title;
  IconData iconData;
  bool selected;
  Function callbackFunction;

  TabBarItem(
      {
        super.key,
        required this.title,
        required this.iconData,
        required this.selected,
        required this.callbackFunction
      }
      );

  @override
  State<TabBarItem> createState() => _TabBarItemState();
}

class _TabBarItemState extends State<TabBarItem> {

  double iconYAlign = ICON_ON;
  double textYAlign = TEXT_OFF;
  double iconAlpha = ALPHA_ON;

  @override
  void initState() {
    super.initState();
    setIconTextAlpha();
  }

  @override
  void didUpdateWidget(covariant TabBarItem oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setIconTextAlpha();
  }

  setIconTextAlpha() {
    setState(() {
      iconYAlign = (widget.selected) ? ICON_OFF : ICON_ON;
      textYAlign = (widget.selected) ? TEXT_ON : TEXT_OFF;
      iconAlpha = (widget.selected) ? ALPHA_OFF : ALPHA_ON;
    });
  }


  @override
  Widget build(BuildContext context) {
    bool textVisible = iconAlpha == 0.0;
    return Expanded(

        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: AnimatedAlign(
                duration: Duration(milliseconds: ANIM_DURATION),
                alignment: Alignment(0, textYAlign),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: ANIM_DURATION),
                    opacity: textVisible ? 1.0 : 0.0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 80), // adjust as needed
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              child: AnimatedAlign(
                duration: Duration(milliseconds: ANIM_DURATION),
                curve: Curves.easeIn,
                alignment: Alignment(0, iconYAlign),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: ANIM_DURATION),
                  opacity: iconAlpha,
                  child: IconButton(
                    icon: Icon(
                      widget.iconData,
                      color: Colors.orangeAccent,
                    ),
                    onPressed: () {
                      widget.callbackFunction();
                    },
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}

