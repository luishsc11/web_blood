import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_blood/view/loginpage.dart';

class Detalhes extends StatelessWidget {
  final Map<String, dynamic> rowData;

  Detalhes({required this.rowData});

  @override
  Widget build(BuildContext context) {
    final String nome = rowData['nome'];
    final String telefone = rowData['telefone'].toString();
    final String tipagem = rowData['tipagem'];
    final String sangue = rowData['sangue'];
    final String datanasc = rowData['datanasc'];
    final String peso = rowData['peso'];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/img.jpg'),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'ADMINISTRADOR - BLOOD DONATION',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        ),
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInfo('Nome', nome, Icons.person),
                  _buildInfo(
                      'Data de Nascimento', datanasc, Icons.calendar_today),
                  _buildInfo('Tipo Sanguíneo', tipagem, Icons.favorite),
                  _buildInfo('Última Vez que Doou Sangue', sangue,
                      Icons.local_hospital),
                  _buildInfo('Peso', '$peso Kg', Icons.fitness_center),
                  _buildInfo('Contato', telefone, Icons.phone),
                  SizedBox(height: 20),
                  _buildWhatsAppButton(telefone, tipagem, nome),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.red,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsAppButton(String telefone, String tipagem, String nome) {
    return ElevatedButton(
      onPressed: () => openWpp(telefone, tipagem, nome),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        onPrimary: Colors.white,
        minimumSize: Size(254, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 2,
      ),
      child: Text('Enviar mensagem via WhatsApp'),
    );
  }

  void openWpp(String telefone, String tipagem, String nome) async {
    String tipagemEncoded = Uri.encodeComponent(tipagem);

    var whatsappUrl =
        "https://web.whatsapp.com/send?phone=55$telefone&text=Olá $nome, obrigado por se cadastrar ao nosso aplicativo de doação de sangue!\n Sua generosidade pode salvar vidas. Estamos com falta de sangue tipo $tipagemEncoded, em nosso banco de sangue, junte-se a nós e faça a diferença.\n Agende sua doação agora!";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
