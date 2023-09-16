import 'package:easy_localization/easy_localization.dart';
import '/business_logic/bouquets/bouquets_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/shared_widgets/header_image.dart';
import '../../widgets/shared_widgets/header_text.dart';
import 'list_content.dart';

class BouquetFirstScreen extends StatelessWidget {
  const BouquetFirstScreen({Key? key}) : super(key: key);
  static const String id = 'bouquet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder:
            (BuildContext ctx, ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return const CustomBouquets();
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

class CustomBouquets extends StatefulWidget {
  const CustomBouquets({Key? key}) : super(key: key);

  @override
  State<CustomBouquets> createState() => _CustomBouquetsState();
}

class _CustomBouquetsState extends State<CustomBouquets> {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BouquetsCubit, BouquetsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Stack(
              children: [
                const HeaderImage(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 30),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: MyColors.myWhite,
                      )),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: HeaderText(
                  text: tr(StringConstants.bouquetOrder),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  tr(StringConstants.chooseUrSuitableBouquet),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14,
                    color: MyColors.myGray,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Expanded(flex: 3, child: ListContent())
          ],
        );
      },
    );
  }
}
