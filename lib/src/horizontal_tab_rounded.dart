part of '../horizontal_tabs.dart';

class _HorizontalTabRounded extends StatefulWidget {
  final double height;
  final int selectedItem;
  final List<String> itemTitles;
  final List<String> itemAssetImagePath;
  final Color backgroundColor;
  final Color unselectedBackgroundColor;
  final Color foregroundColor;
  final Color unselectedForegroundColor;
  final Function(int) onTap;

  const _HorizontalTabRounded({
    required this.height,
    required this.selectedItem,
    required this.itemTitles,
    required this.itemAssetImagePath,
    required this.backgroundColor,
    required this.unselectedBackgroundColor,
    required this.foregroundColor,
    required this.unselectedForegroundColor,
    required this.onTap,
  });

  @override
  State<_HorizontalTabRounded> createState() => _HorizontalTabRoundedState();
}

class _HorizontalTabRoundedState extends State<_HorizontalTabRounded> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      // -----------------------------------
      // Minimum Width Error Checking
      // -----------------------------------
      double padding = 0;
      if (constraints.maxWidth > (widget.height * widget.itemTitles.length)) {
        double difference =
            constraints.maxWidth - (widget.height * widget.itemTitles.length);
        padding = difference / 2;
      }
      if (widget.height < 70) {
        throw FlutterError("Height can not be less than 70");
      }

      // -----------------------------------
      // Main Layout
      // -----------------------------------
      return SizedBox(
        width: constraints.maxWidth,
        height: widget.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.itemTitles.length,
            itemExtent: widget.height,
            itemBuilder: (context, i) {
              bool isSelected = widget.selectedItem == i;
              bool isFirstItem = i == 0;
              bool isLastItem = (i == (widget.itemTitles.length - 1));
              return Stack(
                children: [
                  // -----------------------------------
                  // Arch
                  // -----------------------------------
                  Positioned(
                    left: 0,
                    right: 0,
                    top: isSelected
                        ? i % 2 == 0
                            ? widget.height * 0.2
                            : 0
                        : 0,
                    bottom: isSelected
                        ? i % 2 == 0
                            ? 0
                            : widget.height * 0.2
                        : 0,
                    child: Center(
                      child: CustomPaint(
                        painter: _ArcPainter(
                          color: isSelected
                              ? widget.backgroundColor
                              : widget.unselectedBackgroundColor,
                          isReverse: i % 2 == 0,
                        ),
                        size: Size(widget.height * 0.6, widget.height * 0.6),
                      ),
                    ),
                  ),

                  // -----------------------------------
                  // Line Right
                  // -----------------------------------

                  !isLastItem
                      ? Positioned(
                          top: 0,
                          left: widget.height * 0.8,
                          right: 0,
                          bottom: 0,
                          child: Center(
                            child: Container(
                              height: 2,
                              color: isSelected
                                  ? widget.backgroundColor
                                  : widget.unselectedBackgroundColor,
                            ),
                          ),
                        )
                      : const SizedBox(),

                  // -----------------------------------
                  // Line Left
                  // -----------------------------------
                  !isFirstItem
                      ? Positioned(
                          top: 0,
                          right: widget.height * 0.8,
                          left: 0,
                          bottom: 0,
                          child: Center(
                            child: Container(
                              height: 2,
                              color: isSelected
                                  ? widget.backgroundColor
                                  : widget.unselectedBackgroundColor,
                            ),
                          ),
                        )
                      : const SizedBox(),

                  // -----------------------------------
                  // Item Image
                  // -----------------------------------
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.bounceInOut,
                    left: 0,
                    right: 0,
                    top: isSelected
                        ? i % 2 == 0
                            ? widget.height * 0.2
                            : 0
                        : 0,
                    bottom: isSelected
                        ? i % 2 == 0
                            ? 0
                            : widget.height * 0.2
                        : 0,
                    child: Center(
                      child: Container(
                        height: widget.height * 0.5,
                        width: widget.height * 0.5,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? widget.backgroundColor
                              : widget.unselectedBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(widget.height * 0.48),
                        ),
                        child: Center(
                          child: Image.asset(
                            widget.itemAssetImagePath[i],
                            height: widget.height * .34,
                            width: widget.height * .34,
                            color: isSelected
                                ? widget.foregroundColor
                                : widget.unselectedForegroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // -----------------------------------
                  // Item Text
                  // -----------------------------------
                  isSelected
                      ? Positioned(
                          left: 0,
                          right: 0,
                          top: i % 2 == 0 ? widget.height * 0.07 : null,
                          bottom: i % 2 == 0 ? null : widget.height * 0.07,
                          child: Center(
                            child: Text(
                              widget.itemTitles[i],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: widget.backgroundColor,
                                fontSize: widget.height * 0.14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),

                  // -----------------------------------
                  // On Tap
                  // -----------------------------------
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        widget.onTap(i);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}

// -----------------------------------
// Paint Arch
// -----------------------------------
class _ArcPainter extends CustomPainter {
  final Color color;
  final bool isReverse;

  _ArcPainter({required this.color, required this.isReverse});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      isReverse ? -math.pi : math.pi,
      isReverse ? -math.pi : math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
