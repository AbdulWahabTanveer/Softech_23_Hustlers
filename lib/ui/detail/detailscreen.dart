import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/center_play_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/models/job_model.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:video_player/video_player.dart';

import '../../global_widgets/busy_button.dart';
import '../../global_widgets/custom_text_field.dart';
import '../../models/bid_model.dart';
import '../../models/user_model.dart';
import '../../style/colors.dart';
import 'dialogcontroller.dart';

class DetailScreen extends StatefulWidget {
  final bool fromHandyman;
  const DetailScreen(this.job, {Key? key, this.fromHandyman = false})
      : super(key: key);
  final JobModel job;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentSlider = 0;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  DialogController con = Get.put(DialogController());

  Future<UserModel> getUser() async {
    var doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.job.uid)
        .get();
    return UserModel.fromMap(doc.data()!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: widget.fromHandyman
              ? Padding(
                  padding: EdgeInsets.all(10.h),
                  child: BusyButton(
                    title: 'Bid Now',
                    isBusy: false,
                    onPressed: () {
                      TextEditingController newBid = TextEditingController();
                      Get.defaultDialog(
                          contentPadding: EdgeInsets.all(15.h),
                          title: "Bid Now",
                          content: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("bids")
                                  .where("jobId", isEqualTo: widget.job.id)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  double amount = 0;

                                  snapshot.data!.docs.forEach((element) {
                                    Bid bid = Bid.fromMap(element.data());
                                    if (bid.handymanId ==
                                        FirebaseAuth
                                            .instance.currentUser!.uid) {
                                      con.alreadyExist = true;
                                    }
                                    if (amount > bid.amount) {
                                      amount = bid.amount;
                                    }
                                  });

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.verticalSpace,
                                      Form(
                                        key: form,
                                        child: CustomTextField(
                                          controller: newBid,
                                          validator: (value) {
                                            if (con.alreadyExist) {
                                              return "You cannot Bid twice";
                                            }
                                            if (value == "") {
                                              return "Bid cannot be empty";
                                            }

                                            if (double.parse(newBid.text) >
                                                amount) {
                                              return "Amount Cannot Be More than previous bid";
                                            }

                                            return null;
                                          },
                                          label: 'Bid Amount:',
                                          hint: '10.0',
                                        ),
                                      ),
                                      10.verticalSpace,
                                      Text(
                                        "Highest Bid:\$$amount",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                      10.verticalSpace,
                                      Obx(
                                        () => BusyButton(
                                          title: 'Bid',
                                          isBusy: con.loading.value,
                                          onPressed: () async {
                                            print("ssss");
                                            if (form.currentState!.validate()) {
                                              con.loading.value = true;

                                              await FirebaseFirestore.instance
                                                  .collection("bids")
                                                  .add(Bid(
                                                          id: "",
                                                          accepted: false,
                                                          amount: double.parse(
                                                              newBid.text),
                                                          customerId:
                                                              widget.job.uid,
                                                          handymanId:
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                          jobId: widget.job.id,
                                                          rejected: false)
                                                      .toMap());
                                              con.loading.value = false;
                                              Get.back();
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                );
                              }));
                    },
                  ),
                )
              : SizedBox(),
          body: Container(
            height: 1.sh,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 3),
                            height: 370.h,
                            viewportFraction: 1,
                            onPageChanged: (index, _) {
                              setState(() {
                                currentSlider = index;
                              });
                            }),
                        items: widget.job.images.map<Widget>((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              String s;

                              return i.contains(".mp4")
                                  ? VideouploadWidget(url: i)
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(i))));
                            },
                          );
                        }).toList(),
                      ),
                      Positioned(
                          bottom: 110.h,
                          left: 20.w,
                          child: SizedBox(
                            height: 50.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: widget.job.images.length,
                                itemBuilder: (context, index) {
                                  return widget.job.images[index]
                                          .contains(".mp4")
                                      ? UnconstrainedBox(
                                          child: Container(
                                            height: 50.h,
                                            width: 50.h,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width:
                                                        index == currentSlider
                                                            ? 2
                                                            : 0),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.w)),
                                            child: VideouploadWidget(
                                              url: widget.job.images[index],
                                              small: true,
                                            ),
                                          ),
                                        )
                                      : UnconstrainedBox(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 5.h),
                                            height: 50.h,
                                            width: 50.h,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width:
                                                        index == currentSlider
                                                            ? 2
                                                            : 0),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: Image.network(widget
                                                            .job.images[index])
                                                        .image),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.w)),
                                          ),
                                        );
                                }),
                          )),
                      Positioned(
                        bottom: -85.h,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10.w),
                          child: Container(
                            height: 162.h,
                            width: 0.8.sw,
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.job.category,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                                10.verticalSpace,
                                Text(
                                  widget.job.title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                10.verticalSpace,
                                Text(
                                  "\$ ${widget.job.price}",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                10.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rating",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "0.0",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30.h,
                        left: 30.w,
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  120.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      'Description',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  5.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      widget.job.description,
                      style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      'Timing',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  5.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      "${widget.job.date.hour.toString().padLeft(2, '0')}:${widget.job.date.minute.toString().padLeft(2, '0')}",
                      style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      'About Provider',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  5.verticalSpace,
                  Container(
                    padding: EdgeInsets.all(20.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.h),
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                    ),
                    child: FutureBuilder<UserModel>(
                        future: getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error something went wrong");
                          } else if (snapshot.hasData) {
                            return Row(
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: Image.network(
                                                  snapshot.data!.profileImgUrl!)
                                              .image,
                                          fit: BoxFit.cover)),
                                ),
                                10.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.userName,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    widget.fromHandyman
                                        ? SizedBox()
                                        : Container(
                                            height: 20.h,
                                            child: ListView.builder(
                                                itemCount: 5,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 3.h),
                                                    child: Icon(
                                                      Icons
                                                          .star_border_outlined,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      size: 15.w,
                                                    ),
                                                  );
                                                }),
                                          ),
                                  ],
                                )
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          )),
    );
  }
}

class VideouploadWidget extends StatefulWidget {
  late String? url;
  bool small;

  VideouploadWidget({Key? key, @required this.url, this.small = false})
      : super(key: key);

  @override
  _VideouploadWidgetState createState() => _VideouploadWidgetState();
}

class _VideouploadWidgetState extends State<VideouploadWidget> {
  VideoPlayerController? videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.network(widget.url!);

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
      child: Container(
        height: widget.small ? 50.h : 400.h,
        width: widget.small ? 50.h : 1.sw,
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
