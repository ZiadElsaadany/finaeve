import 'package:easy_localization/easy_localization.dart';
import '/business_logic/Lists/lists_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/string_constants.dart';

class TotalPrizeTemplate extends StatelessWidget {
  const TotalPrizeTemplate({Key? key,  this.number= 0}) : super(key: key);

  final int  number ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListsCubit, ListsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return  state is  InitialPrice? const Center(
          child: CircularProgressIndicator(
            color: MyColors.primaryColor,
          ),
        ): Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02,
              horizontal: MediaQuery.of(context).size.width * 0.02),
          width: double.infinity,
          color: MyColors.myYellow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr(StringConstants.price),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: MyColors.primaryColor,
                      fontSize: 14,
                    ),
              ),
        Text(
        '$number SAR',
        style:
        Theme.of(context).textTheme.headlineLarge!.copyWith(
        color: MyColors.primaryColor,
        fontSize: 14,
        ),
        )

            ],
          ),
        );
      },
    );
  }
}
