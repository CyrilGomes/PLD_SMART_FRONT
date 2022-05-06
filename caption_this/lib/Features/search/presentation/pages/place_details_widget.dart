import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget{
  @override
  _commentState createState() => _commentState();
}

class _commentState extends State<Comments> {
  @override
  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),

                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  Widget comments = const Padding(
    padding: EdgeInsets.all(32),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Place Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            Icon(
              Icons.star,
              color: Colors.red[500],
            ),
          ]),
      body: Center(


        child: ListView(
            children: [
              Image.asset(
                'res/images/bmc.jpg',
                width: 600,
                height: 240,
                fit: BoxFit.cover,
              ),
              const Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                softWrap: true,
              ),
              CommentBox(

                child: commentChild(filedata),
                labelText: 'Write a comment...',
                errorText: 'Comment cannot be blank',
                withBorder: false,
                sendButtonMethod: () {
                  if (formKey.currentState!.validate()) {
                    print(commentController.text);
                    setState(() {
                      var value = {
                        'name': 'New User',
                        'pic':
                        'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                        'message': commentController.text
                      };
                      filedata.insert(0, value);
                    });
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    print("Not validated");
                  }
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: Colors.pink,
                textColor: Colors.white,
                sendWidget: Icon(
                    Icons.send_sharp, size: 30, color: Colors.white),
              ),
            ]
        ),
      ),
    );
  }
}