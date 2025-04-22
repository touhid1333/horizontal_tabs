part of '../horizontal_tabs.dart';

class HorizontalTabView extends StatefulWidget {
  HorizontalTabView._internal({
    this.width,
    this.height,
    this.strokeHeight,
    this.selectedItem,
    this.itemTitles,
    this.itemAssetImagePath,
    this.itemIcons,
    this.backgroundColor,
    this.unselectedBackgroundColor,
    this.foregroundColor,
    this.unselectedForegroundColor,
    this.onTap,
    this.barColor,
  });

  factory HorizontalTabView.basic() =>
      HorizontalTabView._internal().._type = _TabType.basic;

  factory HorizontalTabView.simple({
    required double width,
    required double height,
    required int selectedItem,
    required List<String> itemTitles,
    List<String>? itemAssetImagePath,
    List<IconData>? itemIcons,
    required Color backgroundColor,
    required Color unselectedBackgroundColor,
    required Color foregroundColor,
    required Color unselectedForegroundColor,
    required Function(int) onTap,
  }) =>
      HorizontalTabView._internal(
        width: width,
        height: height,
        selectedItem: selectedItem,
        itemTitles: itemTitles,
        itemAssetImagePath: itemAssetImagePath,
        itemIcons: itemIcons,
        backgroundColor: backgroundColor,
        unselectedBackgroundColor: unselectedBackgroundColor,
        foregroundColor: foregroundColor,
        unselectedForegroundColor: unselectedForegroundColor,
        onTap: onTap,
      ).._type = _TabType.simple;

  factory HorizontalTabView.rounded({
    required double height,
    required int selectedItem,
    required List<String> itemTitles,
    List<String>? itemAssetImagePath,
    List<IconData>? itemIcons,
    required Color backgroundColor,
    required Color unselectedBackgroundColor,
    required Color foregroundColor,
    required Color unselectedForegroundColor,
    required Function(int) onTap,
  }) =>
      HorizontalTabView._internal(
        height: height,
        selectedItem: selectedItem,
        itemTitles: itemTitles,
        itemAssetImagePath: itemAssetImagePath,
        itemIcons: itemIcons,
        backgroundColor: backgroundColor,
        unselectedBackgroundColor: unselectedBackgroundColor,
        foregroundColor: foregroundColor,
        unselectedForegroundColor: unselectedForegroundColor,
        onTap: onTap,
      ).._type = _TabType.rounded;

  factory HorizontalTabView.box({
    required double width,
    required double height,
    required double strokeHeight,
    required int selectedItem,
    required List<String> itemTitles,
    List<String>? itemAssetImagePath,
    List<IconData>? itemIcons,
    required Color foregroundColor,
    required Color unselectedForegroundColor,
    required Function(int) onTap,
  }) =>
      HorizontalTabView._internal(
        width: width,
        height: height,
        strokeHeight: strokeHeight,
        selectedItem: selectedItem,
        itemTitles: itemTitles,
        itemAssetImagePath: itemAssetImagePath,
        itemIcons: itemIcons,
        foregroundColor: foregroundColor,
        unselectedForegroundColor: unselectedForegroundColor,
        onTap: onTap,
      ).._type = _TabType.box;

  factory HorizontalTabView.connected({
    required double width,
    required double height,
    required double strokeHeight,
    required int selectedItem,
    required List<String> itemTitles,
    List<String>? itemAssetImagePath,
    List<IconData>? itemIcons,
    required final Color barColor,
    required final Color backgroundColor,
    required Color foregroundColor,
    required Color unselectedForegroundColor,
    required Function(int) onTap,
  }) =>
      HorizontalTabView._internal(
        width: width,
        height: height,
        strokeHeight: strokeHeight,
        selectedItem: selectedItem,
        itemTitles: itemTitles,
        itemAssetImagePath: itemAssetImagePath,
        itemIcons: itemIcons,
        barColor: barColor,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        unselectedForegroundColor: unselectedForegroundColor,
        onTap: onTap,
      ).._type = _TabType.connected;

  _TabType _type = _TabType.simple;
  final double? width;
  final double? height;
  final double? strokeHeight;
  final int? selectedItem;
  final List<String>? itemTitles;
  final List<String>? itemAssetImagePath;
  final List<IconData>? itemIcons;
  final Color? barColor;
  final Color? backgroundColor;
  final Color? unselectedBackgroundColor;
  final Color? foregroundColor;
  final Color? unselectedForegroundColor;
  final Function(int)? onTap;

  @override
  State<HorizontalTabView> createState() => _HorizontalTabViewState();
}

class _HorizontalTabViewState extends State<HorizontalTabView> {
  List<GlobalKey>? _globalKeysForItems;

  void _initializeGlobalItemKeys() {
    if (widget.itemTitles != null) {
      int count = 0;
      _globalKeysForItems = [];
      while (count < widget.itemTitles!.length) {
        _globalKeysForItems!.add(GlobalKey());
        count++;
      }
    }
  }

  void _handleOnTap(index) async {
    // ensure tap visible position
    if (_globalKeysForItems?[index].currentContext != null) {
      await Scrollable.ensureVisible(
        _globalKeysForItems![index].currentContext!,
        alignment: 0.5,
        curve: Curves.ease,
        duration: const Duration(milliseconds: 200),
      );
    }
    // user tap logic here
    widget.onTap!(index);
  }

  @override
  void initState() {
    _initializeGlobalItemKeys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _globalKeysForItems != null
        ? widget._type == _TabType.simple
            ? _HorizontalTabSimple(
                keys: _globalKeysForItems!,
                width: widget.width!,
                height: widget.height!,
                selectedItem: widget.selectedItem!,
                itemTitles: widget.itemTitles!,
                itemAssetImagePath: widget.itemAssetImagePath,
                itemIcons: widget.itemIcons,
                backgroundColor: widget.backgroundColor!,
                unselectedBackgroundColor: widget.unselectedBackgroundColor!,
                foregroundColor: widget.foregroundColor!,
                unselectedForegroundColor: widget.unselectedForegroundColor!,
                onTap: _handleOnTap)
            : widget._type == _TabType.rounded
                ? _HorizontalTabRounded(
                    keys: _globalKeysForItems!,
                    height: widget.height!,
                    selectedItem: widget.selectedItem!,
                    itemTitles: widget.itemTitles!,
                    itemAssetImagePath: widget.itemAssetImagePath,
                    itemIcons: widget.itemIcons,
                    backgroundColor: widget.backgroundColor!,
                    unselectedBackgroundColor:
                        widget.unselectedBackgroundColor!,
                    foregroundColor: widget.foregroundColor!,
                    unselectedForegroundColor:
                        widget.unselectedForegroundColor!,
                    onTap: _handleOnTap)
                : widget._type == _TabType.box
                    ? _HorizontalTabBox(
                        keys: _globalKeysForItems!,
                        width: widget.width!,
                        height: widget.height!,
                        strokeHeight: widget.strokeHeight!,
                        selectedItem: widget.selectedItem!,
                        itemTitles: widget.itemTitles!,
                        itemAssetImagePath: widget.itemAssetImagePath,
                        itemIcons: widget.itemIcons,
                        foregroundColor: widget.foregroundColor!,
                        unselectedForegroundColor:
                            widget.unselectedForegroundColor!,
                        onTap: _handleOnTap,
                      )
                    : widget._type == _TabType.connected
                        ? _HorizontalTabConnected(
                            keys: _globalKeysForItems!,
                            width: widget.width!,
                            height: widget.height!,
                            strokeHeight: widget.strokeHeight!,
                            selectedItem: widget.selectedItem!,
                            itemTitles: widget.itemTitles!,
                            itemAssetImagePath: widget.itemAssetImagePath,
                            itemIcons: widget.itemIcons,
                            barColor: widget.barColor!,
                            backgroundColor: widget.backgroundColor!,
                            foregroundColor: widget.foregroundColor!,
                            unselectedForegroundColor:
                                widget.unselectedForegroundColor!,
                            onTap: _handleOnTap,
                          )
                        : widget._type == _TabType.basic
                            ? _HorizontalTabBasic(
                                keys: _globalKeysForItems!,
                              )
                            : const SizedBox()
        : const SizedBox();
  }
}
