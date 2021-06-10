import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/auth_model.dart';
import 'package:flutter_application_1/src/providers/auth_provider.dart';

class HomePage extends StatelessWidget {
  final authProvider = new AuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _cargarInformacion(),
    );
  }

  Widget _cargarInformacion() {
    return FutureBuilder(
        future: authProvider.cargarInformacion(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AuthModel>> snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;

            return ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, i) => _crearItem(context, user[i]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, AuthModel auth) {
    return ListTile(
      title: Text('${auth.name}'),
      subtitle: Text('${auth.login}  '),
      onTap: () => Navigator.pushNamed(context, 'login'),
    );
  }
}
