part of '../horizontal_tabs.dart';

class _HorizontalTabSimple extends StatefulWidget {
  final double width;
  final double height;
  final int selectedItem;
  final List<String> itemTitles;
  final List<String> itemAssetImagePath;
  final Color backgroundColor;
  final Color unselectedBackgroundColor;
  final Color foregroundColor;
  final Color unselectedForegroundColor;
  final Function(int) onTap;

  const _HorizontalTabSimple({
    required this.width,
    required this.height,
    required this.selectedItem,
    required this.itemTitles,
    required this.itemAssetImagePath,
    required this.backgroundColor,
    required this.unselectedBackgroundColor,
    required this.foregroundColor,
    required this.unselectedForegroundColor,
    required this.onTap,
  })  : assert(height >= 70),
        assert(selectedItem >= 0 && selectedItem < itemTitles.length),
        assert(itemTitles.length == itemAssetImagePath.length);

  @override
  State<_HorizontalTabSimple> createState() => _HorizontalTabSimpleState();
}

class _HorizontalTabSimpleState extends State<_HorizontalTabSimple> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      // -----------------------------------
      // Minimum Width Error Checking
      // -----------------------------------
      double itemWidth = widget.itemTitles.length <= 4
          ? constraints.maxWidth / widget.itemTitles.length
          : widget.height;
      if (itemWidth < widget.height * 0.5) {
        throw FlutterError("Item width can not be smaller than item height's 40 percent");
      }

      // -----------------------------------
      // Main Layout
      // -----------------------------------
      return SizedBox(
        width: constraints.maxWidth,
        height: widget.height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.itemTitles.length,
          itemExtent: widget.itemTitles.length <= 4
              ? constraints.maxWidth / widget.itemTitles.length
              : widget.height,
          itemBuilder: (context, i) {
            bool isSelected = widget.selectedItem == i;
            bool isFirstItem = i == 0;
            bool isLastItem = (i == (widget.itemTitles.length - 1));
            return SizedBox(
              height: widget.height,
              width: double.maxFinite,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: widget.height * 0.55,
                    child: Center(
                      child: Container(
                        height: widget.height * 0.07,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? widget.backgroundColor
                              : widget.unselectedBackgroundColor,
                          borderRadius: BorderRadius.horizontal(
                            left: isFirstItem ? const Radius.circular(12) : Radius.zero,
                            right: isLastItem ? const Radius.circular(12) : Radius.zero,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: widget.height * 0.475,
                    bottom: widget.height * 0.45,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: widget.height * 0.07,
                        color:
                        isSelected ? widget.backgroundColor : widget.unselectedBackgroundColor,
                      ),
                    ),
                  ),
                  // -----------------------------------
                  // Item Text
                  // -----------------------------------
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(widget.height * 0.07),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? widget.backgroundColor
                              : widget.unselectedBackgroundColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          widget.itemTitles[i],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium?.copyWith(
                              color: isSelected
                                  ? widget.foregroundColor
                                  : widget.unselectedForegroundColor,
                              fontSize: widget.height * 0.14),
                        ),
                      ),
                    ),
                  ),
                  // -----------------------------------
                  // Item Image
                  // -----------------------------------
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(widget.height * 0.07),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? widget.backgroundColor
                              : widget.unselectedBackgroundColor,
                          borderRadius: BorderRadius.circular(widget.height * 0.48),
                        ),
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
              ),
            );
          },
        ),
      );
    });
  }
}