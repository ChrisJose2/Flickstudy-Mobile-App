import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/services/base_service.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/common/utilities/utils.dart';
import 'package:flutter_architecture/common/widgets/app_bar.dart';
import 'package:flutter_architecture/modules/test/view/test_list_view.dart';

class _TestPageItem {
  final String title;
  final String icon;
  final String type;
  final int sequence;

  const _TestPageItem({
    required this.title,
    required this.icon,
    required this.type,
    required this.sequence,
  });

  factory _TestPageItem.fromJson(Map<String, dynamic> json) {
    return _TestPageItem(
      title: (json['title'] ?? '').toString(),
      icon: (json['icon'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      sequence: int.tryParse((json['sequence'] ?? '').toString()) ?? 0,
    );
  }
}

class TestView extends StatefulWidget {
  @override
  TestViewState createState() => TestViewState();
}

class TestViewState extends State<TestView> {
  ValueNotifier<String> imageNotifier =
      ValueNotifier<String>(AppConstants.HOME_TEST_HOPE1);
  Timer? timer;
  int index = 0;

  bool _isLoadingCms = true;
  List<_TestPageItem> _items = const [];
  String? _cmsError;

  @override
  void initState() {
    startImageAnimation();
    _loadCmsConfig();
    super.initState();
  }

  startImageAnimation() {
    Timer.periodic(Duration(seconds: 3), (_t) {
      index++;
      timer = _t;
      imageNotifier.value = index % 2 == 0
          ? AppConstants.HOME_TEST_HOPE1
          : AppConstants.HOME_TEST_HOPE2;
    });
  }

  Future<void> _loadCmsConfig() async {
    try {
      // slug should match the row in `cms.slug`
      final response = await BaseService.post(AppConstants.CMS_DETAILS, {
        "slug": "test_config",
      });

      if (response['replyCode'] != 'success') {
        throw Exception(response['replyMsg'] ?? 'Failed to load CMS config');
      }

      final data = (response['data'] ?? {}) as dynamic;
      final descriptionRaw =
          (data is Map ? (data['description'] ?? '') : '').toString().trim();

      // Node backend stores CMS.description with double-quotes replaced by single-quotes.
      // Convert it back so we can jsonDecode.
      final descriptionJsonString = descriptionRaw.replaceAll("'", '"');
      final decoded = jsonDecode(descriptionJsonString);

      List<dynamic> rawItems;
      if (decoded is Map && decoded['items'] is List) {
        rawItems = decoded['items'] as List<dynamic>;
      } else if (decoded is List) {
        rawItems = decoded;
      } else {
        rawItems = const [];
      }

      final items = rawItems
          .whereType<Map>()
          .map((e) => _TestPageItem.fromJson(e.cast<String, dynamic>()))
          .where((e) => e.title.isNotEmpty && e.type.isNotEmpty)
          .toList()
        ..sort((a, b) => a.sequence.compareTo(b.sequence));

      if (!mounted) return;
      setState(() {
        _items = items;
        _isLoadingCms = false;
        _cmsError = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingCms = false;
        _cmsError = e.toString();
        _items = [];
      });
    }
  }

  Widget _buildItemCard(_TestPageItem item) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.test_list,
          arguments:
              TestListArgs(type: int.parse(item.type), title: item.title)),
      child: Utilities.getCardWithImageText(item.title, item.icon, true),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.home, (Route<dynamic> route) => false);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarView(),
        body: _items.length > 0
            ? SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isLoadingCms)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: LinearProgressIndicator(minHeight: 2),
                        )
                      else if (_cmsError != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Config load failed, showing defaults",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildItemCard(
                              _items.firstWhere((e) => e.sequence == 1)),
                          SizedBox(width: 10),
                          _buildItemCard(
                              _items.firstWhere((e) => e.sequence == 2)),
                          SizedBox(width: 10),
                          _buildItemCard(
                              _items.firstWhere((e) => e.sequence == 3)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: (((MediaQuery.of(context).size.width - 60) /
                                        3) *
                                    2) +
                                10,
                            width: (((MediaQuery.of(context).size.width - 60) /
                                        3) *
                                    2) +
                                10,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              children: [
                                ValueListenableBuilder(
                                    valueListenable: imageNotifier,
                                    builder: (context, value, child) {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        child: Image.network(
                                          imageNotifier.value,
                                          height: (((MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          60) /
                                                      3) *
                                                  2) +
                                              10,
                                          width: (((MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          60) /
                                                      3) *
                                                  2) +
                                              10,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildItemCard(
                                    _items.firstWhere((e) => e.sequence == 4)),
                                SizedBox(height: 10),
                                _buildItemCard(
                                    _items.firstWhere((e) => e.sequence == 5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Container()),
                          Expanded(child: Container()),
                          _buildItemCard(
                              _items.firstWhere((e) => e.sequence == 6)),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
