import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/noticias/screens/agregar_noticia.dart';
import 'package:flutter_application_1/utils/services/firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ListNoticias extends StatefulWidget {
  const ListNoticias({Key? key}) : super(key: key);

  @override
  State<ListNoticias> createState() => _ListNoticiasState();
}

class _ListNoticiasState extends State<ListNoticias> {
  Future<List<Map<String, dynamic>>>? _noticias;

  @override
  void initState() {
    super.initState();
    _fetchNoticias();
  }

  Future<void> _fetchNoticias() async {
    setState(() {
      _noticias = getAllCollection(nameCollection: 'Noticias');
    });
  }

  void _addNoticiaToList(Map<String, dynamic> noticia) {
    setState(() {
      _noticias = _noticias!.then((value) {
        value.insert(0, noticia);
        return value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: GNav(
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {
              },
            ),
            GButton(
              icon: Icons.add,
              text: 'Agregar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNoticia()),
                ).then((result) {
                  if (result != null) {
                    _addNoticiaToList(result);
                  }
                });
              },
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text('Noticias'),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight,
            left: 16.0,
            right: 16.0,
          ),
          child: RefreshIndicator(
            onRefresh: _fetchNoticias,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _noticias,
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No hay datos disponibles'),
                  );
                } else {
                  final data = snapshot.data;

                  return ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 1,
                        color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data?[index]['imagen'] != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(data?[index]['imagen']),
                                  ),
                                ),
                              ),
                            if (data?[index]['titulo'] != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data?[index]['titulo'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, 
                                  ),
                                ),
                              ),
                            if (data?[index]['descripcion'] != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  data?[index]['descripcion'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white, 
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
