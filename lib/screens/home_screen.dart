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
          title: postMdl.loading ? const Text("Loading...") :
          Text(postMdl.post.title.toString()),
        ),
        body:  postMdl.loading ?
        const Center(child: CircularProgressIndicator.adaptive(),)
            : getBody());
  }

  /// displays body of the app
  Widget getBody() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black12,
      padding: const EdgeInsets.all(10),
      child: ListView(
          shrinkWrap: true,
          children: List.generate(postMdl.post.rows!.length, (int index) {
            return getListContentWidget(index);
          })),
    );
  }

  /// List view of card widget that shows each element with title,description and image.
  Widget getListContentWidget(int index) {
    return postMdl.post.rows![index].title != "" && postMdl.post.rows![index].title != null ? Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        color: Colors.white,
        margin: EdgeInsets.only(top: index != 0 ? 11 : 0),
        child: Padding(
          padding:
              const EdgeInsets.only(right: 24, left: 22, top: 22, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                postMdl.post.rows![index].title??"",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            const  SizedBox(
                height: 3,
              ),
              Text(
                  postMdl.post.rows![index].description??"",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12)),
           const SizedBox(
                height: 3,
              ),

              postMdl.post.rows![index].imageHref != null ?
              CachedNetworkImage(imageUrl: postMdl.post.rows![index].imageHref ?? "",
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) {
                    return const Center(child: Icon(Icons.error));
                  })
                  :const SizedBox(),

            ],
          ),
        )) : const SizedBox();
  }
}
