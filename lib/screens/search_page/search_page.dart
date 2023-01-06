import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spotify_clone_provider/methods/string_methods.dart';
import 'package:spotify_clone_provider/models/category.dart';
import 'package:spotify_clone_provider/screens/genre_page/genre_page.dart';
import 'package:spotify_clone_provider/screens/search_results/search_results.dart';

import '../../controllers/main_controller.dart';

class SearchPage extends StatelessWidget {
  final MainController con;
  const SearchPage({
    Key? key,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allTags = tags.map((e) => TagsModel.fromJson(e)).toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Search",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 36,
                          ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 5,
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverSearchAppBar(con: con),
                ),
              ];
            },
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    "Your Top Genre",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ),
                GridView.builder(
                  itemCount: allTags.sublist(0, 4).length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 16 / 18,
                  ),
                  itemBuilder: (context, i) {
                    return TagWidget(tag: allTags.sublist(0, 4)[i], con: con);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    "Browse All",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ),
                GridView.builder(
                    itemCount: allTags.sublist(4).length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      childAspectRatio: 16 / 8,
                      crossAxisSpacing: 14,
                    ),
                    itemBuilder: (context, i) {
                      return TagWidget(
                        tag: allTags.sublist(4)[i],
                        con: con,
                      );
                    }),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  final TagsModel tag;
  final MainController con;
  const TagWidget({
    Key? key,
    required this.tag,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => GenrePage(
              tag: tag,
              con: con,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(
            color: tag.color,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade900,
                offset: const Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 50,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                bottom: 5,
                right: -15,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(385 / 360),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: tag.color,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: kElevationToShadow[2],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: CachedNetworkImage(
                        imageUrl: tag.image,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                        maxHeightDiskCache: 120,
                        maxWidthDiskCache: 120,
                        memCacheHeight:
                            (120 * MediaQuery.of(context).devicePixelRatio)
                                .round(),
                        memCacheWidth:
                            (120 * MediaQuery.of(context).devicePixelRatio)
                                .round(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text(
                  tag.tag.toTitleCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  final MainController con;
  SliverSearchAppBar({
    required this.con,
  });
  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => SearchResultPage(con: con),
            ));
      },
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  const SizedBox(
                    height: 50,
                    child: Icon(CupertinoIcons.search),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Song, Artists of Genres",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey.shade800,
                          fontSize: 18,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 70;

  @override
  // TODO: implement minExtent
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
