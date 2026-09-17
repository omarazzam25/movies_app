import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/api/model/inner_classes/cast.dart';
import '../../../../core/api/widget/main_loading_widget.dart';
import '../../../../core/config/them/app_color.dart';
import '../../../../core/config/them/screen_size.dart';
import '../../../../core/config/them/text_them.dart';
import '../../../../core/utils/app_assets.dart';

class CastWidget extends StatelessWidget {
  final List<Cast> castList;

  const CastWidget({super.key, required this.castList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsetsDirectional.only(
            start: context.width * 0.02,
            bottom: context.height * 0.01,
            top: context.height * 0.01,
            end: context.width * 0.02,
          ),
          decoration: BoxDecoration(
            color: AppColor.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                width: context.width * 0.14,
                height: context.width * 0.14,
                child: CachedNetworkImage(
                  imageUrl: castList[index].urlSmallImage ?? '',
                  placeholder: (context, url) => const MainLoadingWidget(),
                  errorWidget: (context, url, error) =>
                      Image.asset(AppAssets.fallbackUserImage),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('name: ', style: TextThem.robotoBold20White),
                        Expanded(
                          child: Text(
                            castList[index].name ?? 'No name',
                            style: TextThem.robotoBold20White,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'character:',
                          style: TextThem.robotoBold20LightGray,
                        ),
                        Expanded(
                          child: Text(
                            castList[index].characterName ??
                                'no character name',
                            style: TextThem.robotoBold20LightGray,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: context.height * 0.015);
      },
      itemCount: castList.length,
    );
  }
}
