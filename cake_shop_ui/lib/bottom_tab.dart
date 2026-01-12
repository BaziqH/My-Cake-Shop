import 'package:flutter/material.dart';
import 'tab_bar_item.dart';
import 'constants.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Tween<double> positionTween;
  late Animation<double> positionAnimation;

  late AnimationController fadeOutController;
  late Animation<double> fadeOutAnimation;
  late Animation<double> fadeInAnimation;

  double iconAlpha = 1;
  IconData nextIcon = Icons.home;
  IconData activeIcon = Icons.home;

  int currentSelected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupAnimation();
  }

  // void setupAnimation() {
  //   animationController = AnimationController(
  //       vsync: this, duration: const Duration(milliseconds: ANIM_DURATION));
  //   fadeOutController = AnimationController(
  //       vsync: this,
  //       duration: const Duration(milliseconds: (ANIM_DURATION ~/ 5)));
  //
  //   positionTween = Tween<double>(begin: -1, end: -1);
  //   positionAnimation = positionTween.animate(
  //       CurvedAnimation(parent: animationController, curve: Curves.easeOut));
  //
  //   fadeOutAnimation = Tween<double>(begin: 1, end: 0).animate(
  //       CurvedAnimation(parent: fadeOutController, curve: Curves.easeOut))
  //         ..addListener(() {
  //           setState(() {
  //             iconAlpha = fadeOutAnimation.value;
  //           });
  //         })
  //         ..addStatusListener((status) {
  //           if (status == AnimationStatus.completed) {
  //             setState(() {
  //               activeIcon = nextIcon;
  //             });
  //           }
  //         });
  //
  //   fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
  //       parent: animationController,
  //       curve: const Interval(0.8, 1, curve: Curves.easeOut)))
  //     ..addListener(() {
  //       setState(() {
  //         iconAlpha = fadeInAnimation.value;
  //       });
  //     });
  // }

  void setupAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: ANIM_DURATION),
    );

    fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: (ANIM_DURATION ~/ 5)),
    );

    // For 4 items, index 0 should map to -1.0
    double initialAlignment = -1.0;

    positionTween = Tween<double>(
      begin: initialAlignment,
      end: initialAlignment,
    );

    positionAnimation = positionTween.animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    fadeOutAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: fadeOutController, curve: Curves.easeOut),
    )
      ..addListener(() {
        setState(() {
          iconAlpha = fadeOutAnimation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            activeIcon = nextIcon;
          });
        }
      });

    fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.8, 1, curve: Curves.easeOut),
      ),
    )..addListener(() {
      setState(() {
        iconAlpha = fadeInAnimation.value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 65,
          margin: const EdgeInsets.only(top: 45),
          decoration: const BoxDecoration(color: Colors.black, boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
          ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TabBarItem(
                  title: "Home",
                  iconData: Icons.home,
                  selected: currentSelected == 0,
                  callbackFunction: () {
                    int previousIndex = currentSelected;

                    if (previousIndex != 0) {
                      setState(() {
                        nextIcon = Icons.home;
                        currentSelected = 0;
                      });

                      initAnimation(previousIndex.toDouble(), 0);
                    }
                  }),

              TabBarItem(
                title: "Add Order",
                iconData: Icons.receipt_long,
                selected: currentSelected == 1,
                callbackFunction: () {
                  int previousIndex = currentSelected;

                  if (previousIndex != 1) {
                    setState(() {
                      nextIcon = Icons.receipt_long;
                      currentSelected = 1;
                    });

                    initAnimation(previousIndex.toDouble(), 1);
                  }
                },
              ),


              TabBarItem(
                  title: "Pending Orders",
                  iconData: Icons.assignment_add,
                  selected: currentSelected == 2,
                  callbackFunction: () {
                    int previousIndex = currentSelected;

                    if (previousIndex != 2) {
                      setState(() {
                        nextIcon = Icons.assignment_add;
                        currentSelected = 2;
                      });

                      initAnimation(previousIndex.toDouble(), 2);
                    }
                  },
              ),


              TabBarItem(
                  title: "Finalize Order",
                  iconData: Icons.shopping_cart_checkout,
                  selected: currentSelected == 3,
                  callbackFunction: () {
                    int previousIndex = currentSelected;

                    if (previousIndex != 3) {
                      setState(() {
                        nextIcon = Icons.shopping_cart_checkout;
                        currentSelected = 3;
                      });

                      initAnimation(previousIndex.toDouble(), 3);
                    }
                  })

            ],
          ),
        ),
        ignorePointer()
      ],
    );
  }

  // initAnimation(double from, double to) {
  //   positionTween.begin = from;
  //   positionTween.end = to;
  //   animationController.reset();
  //   fadeOutController.reset();
  //   animationController.forward();
  //   fadeOutController.forward();
  // }
  initAnimation(double fromIndex, double toIndex) {

    double from = -1.0 + (fromIndex * (2.0 / 3.0)); // 4 items = 3 gaps
    double to = -1.0 + (toIndex * (2.0 / 3.0));

    print("Animating from: $from to $to");

    positionTween.begin = from;
    positionTween.end = to;

    animationController.reset();
    fadeOutController.reset();
    animationController.forward();
    fadeOutController.forward();

    // print("Animating from: $from to $to");

  }



  IgnorePointer ignorePointer() {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Align(
          heightFactor: 1.5,
          alignment: Alignment(positionAnimation.value, 0),
          child: FractionallySizedBox(
            widthFactor: 1 / 4, /// 4 because we have 4 icons.
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orangeAccent
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Opacity(
                        opacity: iconAlpha,
                        child: Icon(
                          activeIcon, color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
