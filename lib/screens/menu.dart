import 'package:cars_collection/constants/app_colors.dart';
import 'package:cars_collection/constants/app_icons.dart';
import 'package:cars_collection/constants/app_image.dart';
import 'package:cars_collection/constants/app_typography.dart';
import 'package:cars_collection/screens/widgets/navigation_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Menu extends StatefulWidget {
  Widget child;
  Menu({Key? key, required this.child}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selected_index = 1;
  final List<String> _menus = ["Home", "Invoke", "Notification", "My Profile"];
  List<Widget> _navigations = [];
  Tween<double> _animation_tween = Tween<double>(begin: 0, end: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final typography = AppTypography(context);
    _navigations = [
      createNavigtionIcon(path: AppIcons.SHOPPING),
      ..._menus.map((menu) => createNavigationItem(item: menu)).toList(),
      createNavigtionIcon(
          path: AppImage.BADGE, navigationIconType: NavigationIconType.img),
      createNavigtionIcon(path: AppIcons.MENU),
    ];
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 300),
                  tween: _animation_tween,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        SizedBox(height: typography.height * .05),
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.6),
                                        offset: Offset.zero,
                                        blurRadius: 10,
                                        spreadRadius: 0.2,
                                        blurStyle: BlurStyle.outer,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ClipPath(
                                clipper: NavigationClipper(
                                  elements_count: _navigations.length,
                                  selected_index: value,
                                ),
                                child: Container(
                                  height: (typography.height),
                                  width: (typography.width * .25),
                                  decoration: BoxDecoration(
                                    color: AppColors.ACTIVE_COLOR,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: _navigations.reversed
                                        .toList()
                                        .asMap()
                                        .entries
                                        .map(
                                          (e) => Expanded(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                _selected_index == e.key
                                                    ? Positioned(
                                                        right:
                                                            typography.width *
                                                                .12,
                                                        child: Container(
                                                          height:
                                                              typography.width *
                                                                  .015,
                                                          width:
                                                              typography.width *
                                                                  .015,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .SECONDARY_COLOR_DARK,
                                                              shape: BoxShape
                                                                  .circle),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _animation_tween = Tween<
                                                              double>(
                                                          begin: _selected_index
                                                              .toDouble(),
                                                          end:
                                                              e.key.toDouble());
                                                      _selected_index = e.key;
                                                    });
                                                  },
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          right:
                                                              typography.width *
                                                                  .1),
                                                      child: Center(
                                                          child: e.value)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: typography.height * .01),
                      ],
                    );
                  },
                ),
                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createNavigtionIcon(
      {required String path,
      NavigationIconType navigationIconType = NavigationIconType.svg}) {
    return Builder(builder: (context) {
      final typography = AppTypography(context);
      if (navigationIconType == NavigationIconType.svg) {
        return SvgPicture.asset(
          path,
          height: typography.width * .06,
          color: AppColors.SECONDARY_COLOR,
        );
      }
      return Image.asset(
        path,
        height: typography.width * .08,
      );
    });
  }

  Widget createNavigationItem({required String item}) {
    return Builder(builder: (context) {
      final typography = AppTypography(context);
      return RotatedBox(
        quarterTurns: 3,
        child: Text(
          item.toUpperCase(),
          overflow: TextOverflow.ellipsis,
          style:
              TextStyle(fontSize: typography.h2, fontWeight: FontWeight.bold),
        ),
      );
    });
  }
}

enum NavigationIconType { svg, img }
