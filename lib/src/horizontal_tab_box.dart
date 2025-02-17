part of '../horizontal_tabs.dart';

class _HorizontalTabBox extends StatefulWidget {
  final int selectedItem;
  final Function(int) onTap;

  const _HorizontalTabBox({required this.selectedItem, required this.onTap});

  @override
  State<_HorizontalTabBox> createState() => _HorizontalTabBoxState();
}

class _HorizontalTabBoxState extends State<_HorizontalTabBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: LayoutBuilder(builder: (context, constraints) {
        double itemWidth = (constraints.maxWidth - (4 * 5)) / 5;
        return Stack(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        height: 50,
                        width: itemWidth,
                        margin: EdgeInsets.only(
                          right: index != (5 - 1) ? 5 : 0,
                          top: index != widget.selectedItem ? 10 : 0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4)),
                          border: Border(
                            left: BorderSide(
                                color: index == widget.selectedItem
                                    ? Colors.green
                                    : Colors.grey),
                            right: BorderSide(
                                color: index == widget.selectedItem
                                    ? Colors.green
                                    : Colors.grey),
                            top: BorderSide(
                                color: index == widget.selectedItem
                                    ? Colors.green
                                    : Colors.grey),
                            bottom: BorderSide.none,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Test"),
                              if (index == widget.selectedItem)
                                Container(
                                  height: 4,
                                  width: 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.green),
                                )
                            ],
                          ),
                        ),
                      ),
                      // -----------------------------------
                      // On Tap
                      // -----------------------------------
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () {
                            widget.onTap(index);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomPaint(
                painter: _CutLinePainter(
                    color: Colors.green,
                    totalWidth: constraints.maxWidth,
                    itemWidth: itemWidth,
                    spacing: 5,
                    currentIndex: widget.selectedItem,
                    strokeWidth: 2),
                size: Size(constraints.maxWidth, 0),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _CutLinePainter extends CustomPainter {
  final Color color;
  final double totalWidth;
  final double itemWidth;
  final double spacing;
  final int currentIndex;
  final double strokeWidth;

  _CutLinePainter({
    required this.color,
    required this.totalWidth,
    required this.itemWidth,
    required this.spacing,
    required this.currentIndex,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startPoint = 0;
    double endPoint = totalWidth;
    double cutStartPoint =
        ((currentIndex * itemWidth) + (currentIndex * spacing)) + 1;
    double cutEndPoint = (cutStartPoint + itemWidth) - 2;

    canvas.drawLine(Offset(startPoint, 0), Offset(cutStartPoint, 0), paint);
    canvas.drawLine(Offset(cutEndPoint, 0), Offset(endPoint, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
