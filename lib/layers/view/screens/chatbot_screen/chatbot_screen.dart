import 'package:al_dalel/core/configuration/assets.dart';
import 'package:al_dalel/core/configuration/styles.dart';
import 'package:al_dalel/core/utils/size_config.dart';
import 'package:al_dalel/layers/bloc/chatbot/chatbot_cubit.dart';
import 'package:al_dalel/layers/view/screens/chatbot_screen/widget/change_image_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:rive/rive.dart' as Rive;
import '../../../../core/services/assets_loader.dart';
import '../../../../core/ui/responsive_text.dart';
import '../../../../core/ui/waiting_widget.dart';
import '../../../../injection_container.dart';

class ChatBotScreen extends StatelessWidget {
  ChatBotScreen({super.key});

  final _chatBotCubit = sl<ChatBotCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatBotCubit, ChatBotState>(
        bloc: _chatBotCubit,
        builder: (context, state) {
          if (state is ChatBotInitial) {
            return _selectPhotoWidget(context);
          } else if (state is ChatBotLoading) {
            return Center(
              child: WaitingWidget(),
            );
          } else if (state is ChatBotError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is ChatBotLoaded) {
            return GridView.builder(
              itemCount: state.predictedRestaurants.restaurants.length,
              physics: const ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                  mainAxisExtent: 300.0),
              itemBuilder: (context, index) {
                final restaurant =
                    state.predictedRestaurants.restaurants[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 2,
                  duration: Duration(milliseconds: 500),
                  child: SlideAnimation(
                      delay: Duration(milliseconds: 275),
                      child: Stack(
                        children: [
                          _buildImage(restaurant.images.first),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.black.withOpacity(0.9),
                                  Colors.transparent
                                ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ResponsiveText(
                                  textWidget: Text(
                                    restaurant.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                            color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          height: SizeConfig.screenHeight * 0.42,
          width: SizeConfig.screenWidth * 0.49,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Column _selectPhotoWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenWidth,
            child: Rive.RiveAnimation.direct(
                Rive.RiveFile.import(AssetsLoader.chatBot))),
        Text(
          "إبحث عن اي مكان تريده فقط عن طريق صورة",
          style: TextStyle(fontSize: 16),
        ),
        CommonSizes.vSmallSpace,
        TextButton(
          onPressed: () => ChangeImageDialog().showDialog(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "إختر صورة",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              CommonSizes.hSmallSpace,
              Icon(
                Icons.upload,
                color: Colors.white,
              )
            ],
          ),
          style: TextButton.styleFrom(backgroundColor: Styles.colorPrimary),
        )
      ],
    );
  }
}
