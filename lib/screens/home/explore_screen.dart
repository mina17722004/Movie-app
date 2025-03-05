import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:mm/theme/app_colors.dart';

class ExploreWidget extends StatefulWidget {
  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  int _tabTextIndexSelected = 0;


  final List<DataTab> _listTextTabToggle = [
    DataTab(title: "Action"),
    DataTab(title: "Adventure"),
    DataTab(title: "Animation"),
    DataTab(title: "Biography"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 32, horizontal: 4),
          child: FlutterToggleTab(
            unSelectedBackgroundColors: [appColors.grey],
            width: 90,
            borderRadius: 30,
            height: 50,
            selectedIndex: _tabTextIndexSelected,
            selectedBackgroundColors: [appColors.yellow],
            selectedTextStyle: TextStyle(
              color: appColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            unSelectedTextStyle: TextStyle(
              color: appColors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            dataTabs: _listTextTabToggle,
            selectedLabelIndex: (index) {
              setState(() {
                _tabTextIndexSelected = index;
              });
            },
            isScroll: false,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Selected Category: ${_listTextTabToggle[_tabTextIndexSelected].title}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: appColors.white),
            ),
          ),
        ),
      ],
    );
  }
}
