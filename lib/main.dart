import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walkthrough_animation/assets/assets.gen.dart';
import 'package:walkthrough_animation/extensions/duration.dart';

import 'constants.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

// ignore: constant_identifier_names

Offset offset(index, currentIndex) => Offset((index - currentIndex).toDouble(), 0);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFf7eedf),
      ),
      home: const WalkthroughPage(),
    );
  }
}

class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({super.key});

  @override
  State<WalkthroughPage> createState() => _WalkthroughPageState();
}

class _WalkthroughPageState extends State<WalkthroughPage> {
  bool showWalkThroughPages = false;
  int currentIndex = 0;
  int previousIndex = 0;

  bool get isLastPage => currentIndex == pages.length;

  final List<PageModel> pages = [
    PageModel(
      'Relax',
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is dummy text.',
      Assets.images.relax.path,
    ),
    PageModel(
      'Care',
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is dummy text.',
      Assets.images.gym.path,
    ),
    PageModel(
      'Mood Dairy',
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is dummy text.',
      Assets.images.ridingBike.path,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          LetsBeginView(
            top: -(screenSize.height * (showWalkThroughPages ? 1 : 0)),
            onTap: () {
              setState(() {
                showWalkThroughPages = true;
              });
            },
          ),
          WalkthroughPages(
              top: screenSize.height - (screenSize.height * (showWalkThroughPages ? 1 : 0)),
              child: Stack(
                children: [
                  for (int i = 0; i < pages.length; i++)
                    _WalkthroughPageLayout(
                      page: pages[i],
                      index: i,
                      currentIndex: currentIndex,
                    ),
                  ..._buildWelcomePage(),
                ],
              )),
          // Top Nav
          AnimatedPositioned(
            duration: defaultAnimationDuration,
            top: showWalkThroughPages ? 0 : -100,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 32),
                      onPressed: () {
                        setState(() {
                          if (currentIndex > 0) {
                            previousIndex = currentIndex;
                            currentIndex--;
                          } else {
                            showWalkThroughPages = false;
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: const Text('Skip'),
                      onPressed: () {
                        setState(() {
                          currentIndex = pages.length;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            bottom: showWalkThroughPages ? (isLastPage ? 60 : 90) : -100,
            duration: showWalkThroughPages ? defaultAnimationDuration : defaultAnimationDuration.fast(milliseconds: 200),
            left: 20,
            right: 20,
            child: SizedBox(
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      previousIndex = currentIndex;
                      currentIndex = (currentIndex + 1) % (pages.length + 1);
                    });
                  },
                  child: AnimatedContainer(
                    duration: defaultAnimationDuration.delay(),
                    curve: Curves.fastOutSlowIn,
                    height: 60,
                    width: isLastPage ? MediaQuery.of(context).size.width : 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF131d31),
                      borderRadius: BorderRadius.circular(isLastPage ? 12 : 30),
                    ),
                    child: AnimatedPadding(
                      duration: defaultAnimationDuration,
                      padding: EdgeInsets.symmetric(horizontal: isLastPage ? 20 : 0),
                      child: !isLastPage
                          ? const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 24,
                              color: Colors.white,
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Get Started',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildWelcomePage() {
    final index = pages.length;
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedWalkthroughImage(
            currentIndex: currentIndex,
            index: index,
            imagePath: Assets.images.readingBook.path,
            offset: offset(index, currentIndex),
          ),
          const SizedBox(height: 20),
          AnimatedWalkthroughTitle(
            currentIndex: currentIndex,
            index: index,
            title: 'Welcome',
            offset: offset(index, currentIndex),
          ),
          const SizedBox(height: 20),
          AnimatedWalkthroughDescription(
            currentIndex: currentIndex,
            index: index,
            description: 'Stay organized and get more done with the best productivity app',
            offset: offset(index, currentIndex),
          ),
          const SizedBox(height: 40),
        ],
      ),
    ];
  }
}

class LetsBeginView extends StatelessWidget {
  const LetsBeginView({super.key, required this.top, this.onTap});

  final double top;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      left: 0,
      right: 0,
      top: top,
      height: MediaQuery.of(context).size.height,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.yoga.image(
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          Text(
            'Clearhead',
            style: AppTextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 28, top: 8),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is dummy text.',
              textAlign: TextAlign.center,
              style: AppTextStyle(
                // fontWeight: FontWeight.w700,
                color: Colors.grey.shade500,
                letterSpacing: 1.2,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF131d31),
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            child: Text(
              'Let\'s Begin',
              style: AppTextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageModel {
  final String title, description, imagePath;

  PageModel(this.title, this.description, this.imagePath);
}

class WalkthroughPages extends StatelessWidget {
  const WalkthroughPages({super.key, required this.top, required this.child});

  final double top;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      left: 0,
      right: 0,
      top: top,
      height: MediaQuery.of(context).size.height,
      child: child,
    );
  }
}

class _WalkthroughPageLayout extends StatelessWidget {
  const _WalkthroughPageLayout({
    required this.index,
    required this.currentIndex,
    required this.page,
  });
  final PageModel page;
  final int index;
  final int currentIndex;

  final defaultAnimationDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedWalkthroughTitle(
          currentIndex: currentIndex,
          index: index,
          title: page.title,
          offset: offset(index, currentIndex),
        ),
        const SizedBox(height: 20),
        AnimatedWalkthroughDescription(
          currentIndex: currentIndex,
          index: index,
          description: page.description,
          offset: offset(index, currentIndex),
        ),
        const SizedBox(height: 40),
        AnimatedWalkthroughImage(
          currentIndex: currentIndex,
          index: index,
          imagePath: page.imagePath,
          offset: offset(index, currentIndex),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}