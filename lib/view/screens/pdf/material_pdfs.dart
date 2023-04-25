import 'package:flutter/material.dart';
import 'package:studying_app/logic/blocs/materials_bloc/materials_bloc.dart';
import 'package:studying_app/logic/cubits/pdf_cubit/pdf_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/view/screens/pdf/pdf_viewer_page.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/pdf_form.dart';

class MaterialPdfsScreen extends StatelessWidget {
  const MaterialPdfsScreen({super.key});
  static const pageRoute = 'material_pdf_page';

  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final materialName = routeArgus['materialName'];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColors.scaffoldGradientColors.first,
        title: const Text(
          'ملخصات المادة',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 10,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.containerGradient,
        ),
        child: SafeArea(
          child: BlocBuilder<MaterialsBloc, MaterialsState>(
            builder: (context, state) {
              if (state is GotMaterialBooksState) {
                print(state);
                List<String> pdfs = state.books;
                return ListView.builder(
                  itemCount: pdfs.length,
                  itemBuilder: (context, index) {
                    return PdfForm(
                      name: pdfs[index],
                      onTap: () {
                        context.read<PdfCubit>().getPdf(
                              materialName: materialName!,
                              pdfName: pdfs[index],
                            );
                        Navigator.of(context).pushNamed(
                          PdfViewerPage.pageRoute,
                          arguments: {
                            'materialName': materialName,
                            'pdfName':pdfs[index],
                          },
                        );
                      },
                    );
                  },
                );
              } else if (state is GetMaterialErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.scaffoldGradientColors.first,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
