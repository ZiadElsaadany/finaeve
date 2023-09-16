import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import '/peresentation/widgets/album_order_widgets/text_align.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../business_logic/Lists/lists_cubit.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/photos.dart';
import '../../../utilities/constants/string_constants.dart';
import '../../models/list_models.dart';
import '../shared_widgets/text_input_template.dart';
import '../shared_widgets/warning_template.dart';

class EndOrderScreenDetails extends StatefulWidget {
  const EndOrderScreenDetails({Key? key}) : super(key: key);

  @override
  State<EndOrderScreenDetails> createState() => _EndOrderScreenDetailsState();
}

class _EndOrderScreenDetailsState extends State<EndOrderScreenDetails> {
  TextEditingController photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: MyColors.myWhite),
      child: BlocConsumer<ListsCubit, ListsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              TextAlignForRequestAlbum(title:  tr(StringConstants.wayToUploadPhotos)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const WayToUploadPhotoAlbumWithPrint(),



  BlocProvider.of<ListsCubit>(context).emptyOrNotPage4InAlbumWithPrint&&  BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id==""?
    TextAlignForRequestAlbum(

      color:Colors.red,
        title:  tr(StringConstants.noWaysImages)):
  const SizedBox(),


              const SizedBox(
                height: 10,
              ),
              BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id == "2" ||
                      BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id == "3"
                  ? Column(
                    children: [
                      TextFormField(
                          onChanged: (ct) {
                            BlocProvider.of<ListsCubit>(context).setUrlForAlbumWithPrint(ct.trim());
                            print(BlocProvider.of<ListsCubit>(context).urlForAlbumWithPrint);
                          },

initialValue:  BlocProvider.of<ListsCubit>(context).urlForAlbumWithPrint,
                          cursorColor: MyColors.primaryColor,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.myGray)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.myGray)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.myGray)),
                          ),
                        ),
          BlocProvider.of<ListsCubit>(context).urlForAlbumWithPrint.isNotEmpty?
              const SizedBox():TextAlignForRequestAlbum(title: tr(StringConstants.noUrl),
          color: Colors.red,
          )
                    ],
                  )
                  : BlocProvider.of<ListsCubit>(context).wayToUploadPhotoWithPrint?.id == "4"
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                  color: MyColors.myGray.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Display the selected file widget if a file is selected
                                  if (BlocProvider.of<ListsCubit>(context)
                                          .selectedFileFprAlbumWithPrint !=
                                      null)
                                    SelectedFileWidget(
                                        file:
                                            BlocProvider.of<ListsCubit>(context)
                                                .selectedFileFprAlbumWithPrint!),

                                  // Show a button to select a file
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: MyColors.primaryColor,
                                    onPressed: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['zip', 'rar'],
                                      );

                                      if (result != null) {
                                        BlocProvider.of<ListsCubit>(context)
                                            .changeSelectedFileFprAlbumWithPrintFile(
                                            File(
                                                result.files.single.path!));
                                        // Update the UI to display the selected file
                                      }
                                    },
                                    child:  Text(
                                      tr(StringConstants.selectFile),
                                      style: const TextStyle(color: MyColors.myWhite),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015),
                            const WarningTemplate(),
                          ],
                        )
                      : const SizedBox(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              TextAlignForRequestAlbum(title: tr(StringConstants.paperType)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const TypeOfPaperScreen(),
              BlocProvider.of<ListsCubit>(context).emptyOrNotPage4InAlbumWithPrint&&  BlocProvider.of<ListsCubit>(context).paperTypeForAlbumWithPrint?.id==-1?
                  TextAlignForRequestAlbum(
                      color: Colors.red,
                      title: tr(StringConstants.noPaper)):const SizedBox(),


              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),

              const SizedBox(
                height: 15,
              ),

              TextInputTemplate(
                initialValue: BlocProvider.of<ListsCubit>(context)
                      .descriptionForAlbumWithPrint,
                  onChanged: (c) {
                    BlocProvider.of<ListsCubit>(context)
                        .changeDescriptionForAlbumWithPrint(c.trim());


                  },
                  headerTxt: tr(StringConstants.theNotes),
                  hintText: tr(StringConstants.notes)),
            ],
          );
        },
      ),
    );
  }
}

class SelectedFileWidget extends StatefulWidget {
  final File file;

  const SelectedFileWidget({required this.file});

  @override
  _SelectedFileWidgetState createState() => _SelectedFileWidgetState();
}

class _SelectedFileWidgetState extends State<SelectedFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          const Icon(Icons.file_present, size: 48.0),
          const SizedBox(height: 16.0),
          Text(
            widget.file.path.split("/").last,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}


class WayToUploadPhotoAlbumWithPrint extends StatefulWidget {
  const WayToUploadPhotoAlbumWithPrint({Key? key}) : super(key: key);

  @override
  State<WayToUploadPhotoAlbumWithPrint> createState() => _WayToUploadPhotoAlbumWithPrintState();
}

class _WayToUploadPhotoAlbumWithPrintState extends State<WayToUploadPhotoAlbumWithPrint> {
  @override
  Widget build(BuildContext context) {
    return     Container(
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.myGray),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          )),
      padding: const EdgeInsets.all(9.0),
      child: Row(
        children: [
          SvgPicture.asset(PhotosConstants.albumIconG),
          // Your desired icon
          const SizedBox(width: 8.0),
          // Space between icon and label
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                // To take all possible horizontal space
                value: BlocProvider.of<ListsCubit>(context)
                    .wayToUploadPhotoWithPrint
                    ?.name ??
                    "",
                onChanged: (newValue) {
                  BlocProvider.of<ListsCubit>(context)
                      .changeWayToUploadPhotoWithPrint(newValue!);
                  BlocProvider.of<ListsCubit>(context).funGetPrice(context);
                  setState(() {

                  });


                },

                items: List<BaseIdNameModel>.from(context
                    .read<ListsCubit>()

                    .lstWayToUploadPhotoWithPrint!
                  // .map((e) => BaseIdNameModel(
                  //     e.id.toString(), e.name))
                )
                    .map<DropdownMenuItem<String>>(
                      (item) {
                    return DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(item.name,style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: MyColors.myBlack,
                        fontSize: 14,
                      ),),
                    );
                  },
                ).toList() ??
                    [],
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class TypeOfPaperScreen extends StatefulWidget {
  const TypeOfPaperScreen({Key? key}) : super(key: key);

  @override
  State<TypeOfPaperScreen> createState() => _TypeOfPaperScreenState();
}

class _TypeOfPaperScreenState extends State<TypeOfPaperScreen> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.myGray),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          )),
      padding: const EdgeInsets.all(9.0),
      child: Row(
        children: [
          SvgPicture.asset(PhotosConstants.albumIconG),
          // Your desired icon
          const SizedBox(width: 8.0),
          // Space between icon and label
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                // To take all possible horizontal space
                value: BlocProvider.of<ListsCubit>(context)
                    .paperTypeForAlbumWithPrint
                    ?.name,
                onChanged: (newValue) {
                  BlocProvider.of<ListsCubit>(context)
                      .changePaperTypeForAlbumWithPrint(newValue!);

                  BlocProvider.of<ListsCubit>(context).funGetPrice(context);

                  setState(() {

                  });
                },

                items: List<PaperType>.from(context
                    .read<ListsCubit>()
                    .lstPaperTypeForAlbumWithPrint!
                  // .map((e) => BaseIdNameModel(
                  //     e.id.toString(), e.name))
                )
                    .map<DropdownMenuItem<String>>(
                      (item) {
                    return DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(item.name,style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: MyColors.myBlack,
                        fontSize: 14,
                      ),),
                    );
                  },
                ).toList() ??
                    [],
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

