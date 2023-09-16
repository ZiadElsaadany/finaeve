import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/album_order/album_details_row_cubit.dart';
import '../../widgets/album_order_widgets/print_album_details_row_template.dart';
import '../../widgets/album_order_widgets/album_specification_details.dart';
import 'album_data_screen.dart';
import 'album_materials_screen.dart';
import 'end_order_screen.dart';

class PrintAlbumScreen extends StatefulWidget {
  const PrintAlbumScreen({Key? key}) : super(key: key);

  @override
  State<PrintAlbumScreen> createState() => _PrintAlbumScreenState();
}

class _PrintAlbumScreenState extends State<PrintAlbumScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            const PrintAlbumDetailsRow(),
            BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfAlbumPrint ==
                    0
                ? const SpecificationDetails()
                : BlocProvider.of<AlbumDetailsRowCubit>(context)
                            .indexOfAlbumPrint ==
                        1
                    ? const AlbumMaterialScreen()
                    : BlocProvider.of<AlbumDetailsRowCubit>(context)
                                .indexOfAlbumPrint ==
                            2
                        ? const AlbumDataScreen()
                        : const EndOrderScreen(),
            // const TotalPrizeTemplate(),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.005),
            // state is SendRequestLoadingStates
            //     ? const CircularProgressIndicator(
            //         backgroundColor: MyColors.primaryColor,
            //       )
            //     : const SendOrdertoCartOnPrintAlbum()
          ],
        );
      },
    );
  }
}
//
// class SendOrdertoCartOnPrintAlbum extends StatelessWidget {
//   const SendOrdertoCartOnPrintAlbum({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.of<AlbumDetailsRowCubit>(context).indexOfAlbumPrint ==
//                 3 &&
//             BlocProvider.of<AlbumDetailsRowCubit>(context)
//                     .indexOfSelectedRequestOfAlbum ==
//                 0
//         ? EndButton()
//         : BlocConsumer<AlbumDetailsRowCubit, AlbumDetailsRowState>(
//             listener: (context, state) {
//               // TODO: implement listener
//             },
//             builder: (context, state) {
//               return ElevatedButtonTemplate(
//                   buttonText: tr(StringConstants.theNext),
//                   buttonColor: MyColors.primaryColor,
//                   onPressed: () {
//                     BlocProvider.of<AlbumDetailsRowCubit>(context)
//                         .plusIndexOfAlbumPrint();
//                   });
//             },
//           );
//   }
// }

// class EndButton extends StatelessWidget {
//   EndButton({Key? key}) : super(key: key);
//
// // Check if a file is selected or not
//
//   @override
//   Widget build(BuildContext context) {
//     File? selectedFile = BlocProvider.of<ListsCubit>(context).selectedFile;
//
//     final image = selectedFile;
//     File? selectedFile2 =
//         BlocProvider.of<ListsCubit>(context).uploadAnotherModelOfPHOTO;
//
//     final image2 = selectedFile2;
//     return MaterialButton(
//       minWidth: MediaQuery.of(context).size.width,
//       color: MyColors.primaryColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Text(
//         tr(StringConstants.addOrderToCart),
//         style: const TextStyle(color: MyColors.myWhite),
//       ),
//       onPressed: () {
//         sendRequestAlbumToCart(context,
//             image2: image2, selectedFile: selectedFile);
//       },
//     );
//   }
// }
//
// class NextButtonOfPrintAlbum extends StatelessWidget {
//   const NextButtonOfPrintAlbum({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButtonTemplate(
//         buttonText: tr(StringConstants.theNext),
//         buttonColor: MyColors.primaryColor,
//         onPressed: () {
//           BlocProvider.of<AlbumDetailsRowCubit>(context)
//               .plusIndexOfAlbumPrint();
//         });
//   }
// }
