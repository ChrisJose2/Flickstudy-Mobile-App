import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/watchout/view_model/watchout_view_model.dart';
import 'package:provider/provider.dart';

class WatchoutDetailView extends StatefulWidget {
  @override
  WatchoutDetailViewState createState() => WatchoutDetailViewState();
}

class WatchoutDetailViewState extends State<WatchoutDetailView> {
  late WatchOutViewModel watchOutViewModel;

  @override
  void initState() {
    watchOutViewModel = Provider.of<WatchOutViewModel>(context, listen: false);
    super.initState();
  }

  String? watchOutName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is int) {
      print(arguments);
      watchOutViewModel.watchOutList!.watchOutList.forEach((element) {
        if (element.id == arguments) {
          watchOutName = element.title;
        }
      });
      if (watchOutName != null) {
        watchOutViewModel.getWatchOutDetails(arguments);
      }
    }
  }

  bool newsSelected = true;
  int selectedTile = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchOutViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarViewV2(title: watchOutName ?? "Watchout Name"),
            body: watchOutViewModel.watchOutDetailLoadingStatus
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/imgs/watchout_view/dummy.png"),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              CustomTextField(
                                  text: '3 min',
                                  styleFace: CustomTextStyles.r8.darkGrey),
                              SizedBox(width: 20),
                              CustomTextField(
                                  text: 'Jagran Josh',
                                  styleFace: CustomTextStyles.r8.darkGrey),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: MediaQuery.of(context).size.height * .6,
                            child: CustomTextField(
                              text:
                                  watchOutViewModel.watchOutDetail!.description,
                              styleFace: CustomTextStyles.r12,
                            ),
                          )
                        ],
                      ),
                    )));
      },
    );
  }
}
