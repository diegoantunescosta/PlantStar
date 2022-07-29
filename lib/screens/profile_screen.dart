import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantstar/resources/auth_methods.dart';
import 'package:plantstar/resources/firestore_methods.dart';
import 'package:plantstar/screens/login_screen.dart';
import 'package:plantstar/utils/colors.dart';
import 'package:plantstar/utils/utils.dart';
import 'package:plantstar/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: Image.asset(
                'assets/images/logo.png',
                height: 50,
              ),
              title: Text('Perfil'),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xFFFFCA7A), Color(0xFFFF918D)]),
                ),
              ),
            ),
            body: ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              userData['photoUrl'],
                            ),
                            radius: 60,
                          ),
                        ],
                      ),
                      const Divider(),
                      Container(
                        child: Text(
                          userData['username'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      const Divider(),
                      Container(
                        child: Text(
                          userData['bio'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: white),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildStatColumn(postLen, "Postagens"),
                          buildStatColumn(followers, "Seguidores"),
                          buildStatColumn(following, "Seguindo"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FirebaseAuth.instance.currentUser!.uid == widget.uid
                              ? FollowButton(
                                  text: 'Sair',
                                  backgroundColor: primaryLight,
                                  textColor: Color.fromARGB(255, 255, 255, 255),
                                  borderColor:
                                      Color.fromARGB(255, 94, 218, 111),
                                  function: () async {
                                    await AuthMethods().signOut();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                )
                              : isFollowing
                                  ? FollowButton(
                                      text: 'Deixar de seguir',
                                      backgroundColor: secondaryColor,
                                      textColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      borderColor:
                                          Color.fromARGB(255, 94, 218, 111),
                                      function: () async {
                                        await FireStoreMethods().followUser(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          userData['uid'],
                                        );

                                        setState(() {
                                          isFollowing = false;
                                          followers--;
                                        });
                                      },
                                    )
                                  : FollowButton(
                                      text: 'Seguir',
                                      backgroundColor: Colors.blue,
                                      textColor:
                                          Color.fromARGB(255, 10, 10, 10),
                                      borderColor: Colors.blue,
                                      function: () async {
                                        await FireStoreMethods().followUser(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          userData['uid'],
                                        );

                                        setState(() {
                                          isFollowing = true;
                                          followers++;
                                        });
                                      },
                                    )
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                        return Container(
                          child: Image(
                            image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 29, 134, 8),
            ),
          ),
        ),
      ],
    );
  }
}
