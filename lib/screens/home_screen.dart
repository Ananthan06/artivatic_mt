/// This is the home page of application.
import 'package:artivatic_mt/providers/data_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PostDataProvider postMdl;

  @override
  void initState() {
    final postMdl = Provider.of<PostDataProvider>(context, listen: false);
    postMdl.getPostData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    postMdl = Provider.of<PostDataProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: postMdl.loading
              ? const Text("Loading...")
              : Text(postMdl.post.title ?? "Artivatic Demo"),
          actions: [getRefresh()],
        ),
        body: postMdl.loading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : !postMdl.networkNotAvailable
                ? getBody()
                : const Center(
                    child: Text(
                      "NETWORK UNAVAILABLE !",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ));
  }

  /// displays body of the app
  Widget getBody() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black12,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          getSearchBar(),
          Expanded(
            child: postMdl.data != null && postMdl.data!.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () => postMdl.getPostData(context),
                    child: ListView(
                        shrinkWrap: true,
                        children:
                            List.generate(postMdl.data!.length, (int index) {
                          return getListContentWidget(index);
                        })),
                  )
                : getNoDataFound(),
          ),
        ],
      ),
    );
  }

  ///Text field widget to search items offline.
  Widget getSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 10),
      child: TextField(
        decoration: const InputDecoration(
          hintText: "Search",
          icon: Icon(Icons.search),
          border: InputBorder.none,
        ),
        controller: postMdl.controller,
        onChanged: (value) {
          Provider.of<PostDataProvider>(context, listen: false)
              .changeSearchString(value);
        },
      ),
    );
  }

  /// List view of card widget that shows each element with title,description and image.
  Widget getListContentWidget(int index) {
    return postMdl.data![index].title != "" &&
            postMdl.data![index].title != null
        ? Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            color: Colors.white,
            margin: EdgeInsets.only(top: index != 0 ? 11 : 0),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 24, left: 22, top: 22, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postMdl.data![index].title ?? "",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(postMdl.data![index].description ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12)),
                  const SizedBox(
                    height: 3,
                  ),
                  postMdl.data![index].imageHref != null
                      ? CachedNetworkImage(
                          imageUrl: postMdl.data![index].imageHref ?? "",
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) {
                            return const Center(child: Icon(Icons.error));
                          })
                      : const SizedBox(),
                ],
              ),
            ))
        : const SizedBox();
  }

  ///Returns No data found text when list is empty.
  Widget getNoDataFound() {
    return const Center(
      child: Text(
        "NO DATA FOUND !",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  /// refresh button in app bar to reload the list by calling api
  Widget getRefresh() {
    return InkWell(
      onTap: () => postMdl.getPostData(context),
      child: const Icon(
        Icons.refresh,
        color: Colors.white,
      ),
    );
  }
}
