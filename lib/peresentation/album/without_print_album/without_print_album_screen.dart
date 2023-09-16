import '/peresentation/album/without_print_album/materilas_without_print_screen.dart';
import '/peresentation/album/without_print_album/without_print_album_data.dart';
import '/peresentation/widgets/without_print_album/circles_avatar_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import 'specifications_details_without_print.dart';


class WithoutPrintAlbumScreen extends StatelessWidget {
  const WithoutPrintAlbumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            const CirclesAvatarRow(),
            BlocProvider.of<AlbumDetailsRowCubit>(context)
                        .indexOfAlbumWithoutCircleAvatarPrint ==
                    0
                ?  const WithoutPrintSpecifications()
                : BlocProvider.of<AlbumDetailsRowCubit>(context)
                            .indexOfAlbumWithoutCircleAvatarPrint ==
                        1
                    ?  WithoutPrintMaterials()
                    : const WithoutPrintAlbumData(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.005),

          ],
        );
      },
    );
  }
}
