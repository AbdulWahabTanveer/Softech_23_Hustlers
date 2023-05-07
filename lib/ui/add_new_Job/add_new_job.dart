import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:chewie/src/center_play_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/global_widgets/custom_text_field.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/utils/CustomSuffix.dart';
import 'package:softech_hustlers/utils/common_image_view.dart';
import 'package:video_player/video_player.dart';

import '../../global_widgets/services_category_dropdown.dart';
import '../../style/app_theme.dart';
import '../../style/textstyles.dart';
import 'add_new_job_controller.dart';

class AddNewJob extends StatelessWidget {
  AddNewJob({Key? key}) : super(key: key);
  final controller = Get.put(AddNewJobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Job"),
        backgroundColor: Get.theme.primaryColor ==
            AppTheme.darkTheme.primaryColor
            ? appBackgroundColor
            : null,),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kpHorizontalPadding.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  20.verticalSpace,
                  CustomTextField(
                    controller: controller.jobTitle,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please enter job title";
                      } else {
                        return null;
                      }
                    },
                    label: "Job title",
                    hint: "Job title",
                    suffix: const CustomSuffix(FontAwesomeIcons.briefcase),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.jobDescription,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please enter job description";
                      } else {
                        return null;
                      }
                    },
                    label: "Job Description",
                    hint: "Job Description",
                    suffix: const CustomSuffix(FontAwesome.clipboard),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.price,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please enter job price";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    label: "Price in dollars",
                    hint: "Price in dollars",
                    suffix: const CustomSuffix(FontAwesome.money),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.date,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please enter job date";
                      } else {
                        return null;
                      }
                    },
                    label: "Date",
                    hint: "Date",
                    suffix: const CustomSuffix(FontAwesome.calendar),
                    isDisabled: true,
                    onTap: () {
                      controller.pickDate(context);
                    },
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.time,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please enter job time";
                      } else {
                        return null;
                      }
                    },
                    label: "Time",
                    hint: "Time",
                    suffix: const CustomSuffix(FontAwesome.clock_o),
                    isDisabled: true,
                    onTap: () {
                      controller.pickTime(context);
                    },
                  ),
                  10.verticalSpace,
                  ServiceCategoryDropdown(
                    onChange: (String v) {
                      controller.selectedCategory.value = v;
                    },
                    value: controller.selectedCategory.value,
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.location,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please select location";
                      } else {
                        return null;
                      }
                    },
                    label: "Location",
                    hint: "Location",
                    suffix: const CustomSuffix(FontAwesome.location_arrow),
                    isDisabled: true,
                    onTap: () async {
                      controller.ontapLocation();
                    },
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.picture,
                    validator: (val) {
                      if (controller.jobImages.isNotEmpty) {
                        return null;
                      } else {
                        return "Please enter atleast 1 image";
                      }
                    },
                    label: "Add Picture",
                    hint: "Press here to add picture",
                    suffix: const CustomSuffix(
                      FontAwesome.camera,
                    ),
                    isDisabled: true,
                    onTap: () {
                      controller.pickImage();
                    },
                  ),
                  10.verticalSpace,
                  Obx(() {
                    return controller.jobImages.value.isEmpty
                        ? Container(
                            height: 20.h,
                          )
                        : SizedBox(
                            height: 100.h,
                            width: 1.sw,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.jobImages.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: 12.w, bottom: 10.h),
                                    child: Stack(
                                      children: [
                                        controller.jobImages[index].paths[0]!
                                                .contains("mp4")
                                            ? VideouploadWidget(
                                                url: File(controller
                                                    .jobImages[index]
                                                    .paths[0]!))
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.w),
                                                child: CommonImageView(
                                                  file: File(controller
                                                      .jobImages[index]
                                                      .paths[0]!),
                                                  width: 100.w,
                                                ),
                                              ),
                                        Positioned(
                                            top: 10.h,
                                            right: 10.w,
                                            child: InkWell(
                                              onTap: () {
                                                controller.jobImages
                                                    .removeAt(index);
                                              },
                                              child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                  )),
                                            ))
                                      ],
                                    ),
                                  );
                                }),
                          );
                  }),
                  Obx(() {
                    return BusyButton(
                      title: "Add Job",
                      isBusy: controller.isBusy.value,
                      onPressed: () {
                        controller.addJob();
                      },
                    );
                  }),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VideouploadWidget extends StatefulWidget {
  late File? url;

  VideouploadWidget({Key? key, @required this.url}) : super(key: key);

  @override
  _VideouploadWidgetState createState() => _VideouploadWidgetState();
}

class _VideouploadWidgetState extends State<VideouploadWidget> {
  VideoPlayerController? videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.file(widget.url!);

    _initializeVideoPlayerFuture =
        videoPlayerController!.initialize().then((_) {
      setState(() {});
    });
  } // This closing tag was missing

  @override
  void dispose() {
    videoPlayerController!.dispose();
    //    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Container(
        height: 100.h,
        width: 100.w,
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                color: Colors.black45,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Chewie(
                    key: new PageStorageKey(widget.url),
                    controller: ChewieController(
                      customControls: const customControl(),
                      videoPlayerController: videoPlayerController!,
                      aspectRatio: 1.1,
                      showControls: true,

                      // Prepare the video to be played and display the first frame
                      autoInitialize: true,
                      looping: false,
                      autoPlay: false,
                      // Errors can occur for example when trying to play a video
                      // from a non-existent URL
                      errorBuilder: (context, errorMessage) {
                        return Center(
                          child: Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class customControl extends StatefulWidget {
  const customControl({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _customControlState();
  }
}

class _customControlState extends State<customControl>
    with SingleTickerProviderStateMixin {
  late VideoPlayerValue _latestValue;
  double? _latestVolume;
  bool _hideStuff = true;
  Timer? _hideTimer;
  Timer? _initTimer;
  late var _subtitlesPosition = const Duration();
  bool _subtitleOn = false;
  Timer? _showAfterExpandCollapseTimer;
  bool _dragging = false;
  bool _displayTapped = false;

  final barHeight = 48.0;
  final marginSize = 5.0;

  late VideoPlayerController controller;
  ChewieController? _chewieController;
  // We know that _chewieController is set in didChangeDependencies
  ChewieController get chewieController => _chewieController!;

  @override
  Widget build(BuildContext context) {
    if (_latestValue.hasError) {
      return chewieController.errorBuilder?.call(
            context,
            chewieController.videoPlayerController.value.errorDescription!,
          ) ??
          const Center(
            child: Icon(
              Icons.error,
              color: Colors.white,
              size: 42,
            ),
          );
    }

    return MouseRegion(
      onHover: (_) {
        _cancelAndRestartTimer();
      },
      child: GestureDetector(
        onTap: () => _cancelAndRestartTimer(),
        child: AbsorbPointer(
          absorbing: _hideStuff,
          child: Column(
            children: <Widget>[
              if (_latestValue.isBuffering)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                _buildHitArea(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    controller.removeListener(_updateState);
    _hideTimer?.cancel();
    _initTimer?.cancel();
    _showAfterExpandCollapseTimer?.cancel();
  }

  @override
  void didChangeDependencies() {
    final _oldController = _chewieController;
    _chewieController = ChewieController.of(context);
    controller = chewieController.videoPlayerController;

    if (_oldController != chewieController) {
      _dispose();
      _initialize();
    }

    super.didChangeDependencies();
  }

  Expanded _buildHitArea() {
    final bool isFinished = _latestValue.position >= _latestValue.duration;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_latestValue.isPlaying) {
            if (_displayTapped) {
              setState(() {
                _hideStuff = true;
              });
            } else {
              _cancelAndRestartTimer();
            }
          } else {
            _playPause();

            setState(() {
              _hideStuff = true;
            });
          }
        },
        child: Opacity(
          opacity: 0.5,
          child: CenterPlayButton(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            isFinished: isFinished,
            isPlaying: controller.value.isPlaying,
            show: !_latestValue.isPlaying && !_dragging,
            onPressed: _playPause,
          ),
        ),
      ),
    );
  }

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();
    _startHideTimer();

    setState(() {
      _hideStuff = false;
      _displayTapped = true;
    });
  }

  Future<void> _initialize() async {
    _subtitleOn = chewieController.subtitle?.isNotEmpty ?? false;
    controller.addListener(_updateState);

    _updateState();

    if (controller.value.isPlaying || chewieController.autoPlay) {
      _startHideTimer();
    }

    if (chewieController.showControlsOnInitialize) {
      _initTimer = Timer(const Duration(milliseconds: 200), () {
        setState(() {
          _hideStuff = false;
        });
      });
    }
  }

  void _playPause() {
    final isFinished = _latestValue.position >= _latestValue.duration;

    setState(() {
      if (controller.value.isPlaying) {
        _hideStuff = false;
        _hideTimer?.cancel();
        controller.pause();
      } else {
        _cancelAndRestartTimer();

        if (!controller.value.isInitialized) {
          controller.initialize().then((_) {
            controller.play();
          });
        } else {
          if (isFinished) {
            controller.seekTo(const Duration());
          }
          controller.play();
        }
      }
    });
  }

  void _startHideTimer() {
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  void _updateState() {
    if (!mounted) return;
    setState(() {
      _latestValue = controller.value;
      _subtitlesPosition = controller.value.position;
    });
  }
}
