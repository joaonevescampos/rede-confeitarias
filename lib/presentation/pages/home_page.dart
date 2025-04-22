import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rede de Confeitarias', 
          style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
          ),
          ),
      ),
      drawer: Drawer(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text('Bem-vindo(a) a sua rede de Confeitarias!', 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.secondary, 
                      fontSize: 28, 
                      fontWeight: FontWeight.bold,
                    ),
                  )
                )
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text('Tenha o controle da sua rede de lojas na palma da sua mão. Cadastre sua confeitaria e produtos de onde estiver!', 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.secondary, 
                      fontSize: 16, 
                    ),
                  )
                )
              ),
              Image.asset('lib/assets/images/confeitaria.png', width: 250,),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Começar'),
                   style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.quarternary, // Cor de fundo do botão
                      foregroundColor: Colors.white, // Cor do texto quando o botão está pressionado
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0), // Padding interno
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), // Bordas arredondadas
                      ),
                      elevation: 5, // Sombra do botão
                      minimumSize: Size(200, 40)
                ),
                ),
              )
            ],
          )
          // Image(image: FileImage(file),)
        ],
      ),
    );
  }
}