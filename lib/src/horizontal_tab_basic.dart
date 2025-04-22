part of '../horizontal_tabs.dart';

class _HorizontalTabBasic extends StatefulWidget {
  final List<GlobalKey> keys;

  const _HorizontalTabBasic({required this.keys});

  @override
  State<_HorizontalTabBasic> createState() => _HorizontalTabBasicState();
}

class _HorizontalTabBasicState extends State<_HorizontalTabBasic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 40,
              width: double.maxFinite,
              color: Colors.green,
              child: Center(
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 40,
              width: double.maxFinite,
              color: Colors.grey,
              child: Center(
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 40,
              width: double.maxFinite,
              color: Colors.grey,
              child: Center(
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
