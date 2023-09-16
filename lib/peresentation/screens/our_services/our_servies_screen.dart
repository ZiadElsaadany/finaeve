import 'package:easy_localization/easy_localization.dart';
import '/peresentation/screens/our_services/our_services_item.dart';
import '/peresentation/widgets/custom_appbar.dart';
import '/peresentation/widgets/shared_widgets/header_text.dart';
import '/utilities/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../../business_logic/our_services/our_services_cubit.dart';
import '../../widgets/circle_lottie_loading.dart';
import '../../widgets/no_internet_widget.dart';

class OurServicesScreen extends StatelessWidget {
  const OurServicesScreen({Key? key}) : super(key: key);
  static const String id = 'ourServices';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: OfflineBuilder(
        connectivityBuilder:
            (BuildContext ctx, ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return const CustomOurServices();
            // widget with initState   -->   apis
          } else {
            return child;
          }
        },
        child: NoInternetWidget(
          txt: tr(StringConstants.noInternet),
        ),
      ),
    );
  }
}

class CustomOurServices extends StatefulWidget {
  const CustomOurServices({Key? key}) : super(key: key);

  @override
  State<CustomOurServices> createState() => _CustomOurServicesState();
}

class _CustomOurServicesState extends State<CustomOurServices> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<OurServicesCubit>(context).getOurServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OurServicesCubit, OurServicesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: state is LoadingStateOurServices
              ? const CircleLoadingByLottie()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HeaderText(text: tr(StringConstants.ourServices)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const OurServicesItems(),
                  ],
                ),
        );
      },
    );
  }
}
