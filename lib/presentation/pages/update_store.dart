import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/presentation/components/custom_drawer.dart';
import 'package:rede_confeitarias/presentation/components/custom_input.dart';
import 'package:rede_confeitarias/presentation/components/map.dart';
import 'package:rede_confeitarias/repositories/store_repository.dart';
import 'package:rede_confeitarias/services/cep_service.dart';

import '../../models/store_model.dart';

class UpdateStore extends StatefulWidget {
  final int? idStore;

  const UpdateStore({Key? key, required this.idStore}) : super(key: key);

  @override
  State<UpdateStore> createState() => _UpdateStoreState();
}

class _UpdateStoreState extends State<UpdateStore> {
  final StoreRepository _storeRepository = StoreRepository();
  String responseMessage = '';
  Store? storeData;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController cepController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController ufController = TextEditingController();
  late TextEditingController cityController = TextEditingController();
  late TextEditingController neighborhoodController = TextEditingController();
  LatLng? coordenates;

    @override
  void initState() {
    super.initState();
    fetchStore();
  }

  Future<void> fetchStore() async {
    if (widget.idStore == null) {
      setState(() {
        responseMessage = 'Loja não encontrada.';
      });
      return;
    }
    // Exemplo: usando seu StoreRepository para pegar a loja
    final store = await _storeRepository.getStoreById(widget.idStore!);
    print('foi feito o fetch - get!!!!');
    
    setState(() {
      storeData = store;
      nameController = TextEditingController(text: storeData?.storeName);
      cepController = TextEditingController(text: storeData?.cep);
      phoneController = TextEditingController(text: storeData?.phone);
      addressController = TextEditingController(text: storeData?.address);
      ufController = TextEditingController(text: storeData?.uf);
      cityController = TextEditingController(text: storeData?.city);
      neighborhoodController = TextEditingController(text: storeData?.neighborhood);
      coordenates = LatLng(storeData!.latitude, storeData!.longitude);

      // isLoading = false;
    });

    print(storeData?.storeName);
    print(storeData?.phone);
    print(storeData?.id);
    print(storeData?.city);
    print(storeData?.latitude);
    print(storeData?.longitude);
    print(storeData?.cep);
    print(storeData?.uf);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Atualizar Confeitaria',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Informe os dados da sua confeitaria.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomInput(
                  label: 'Nome da loja',
                  maxLength: 30,
                  keyboardType: TextInputType.text,
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: 'Telefone',
                  maxLength: 13,
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: CustomInput(
                        label: 'CEP',
                        maxLength: 8,
                        keyboardType: TextInputType.number,
                        controller: cepController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          final cep = cepController.text;
                          final data = await fetchAddressFromCep(cep);

                          if (data != null) {
                            addressController.text = data['logradouro'] ?? '';
                            cityController.text = data['cidade'] ?? '';
                            ufController.text = data['estado'] ?? '';
                            neighborhoodController.text = data['bairro'] ?? '';

                            final coords = await searchCoordenates(
                              cep: cep,
                              cidade: data['cidade'] ?? '',
                              estado: data['estado'] ?? '',
                              logradouro: data['logradouro'] ?? '',
                            );

                            if (coords != null) {
                              setState(() {
                                coordenates = coords;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Coordenadas não encontradas', style: TextStyle(color: Colors.white),), backgroundColor: Colors.red,),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('CEP não encontrado', style: TextStyle(color: Colors.white),), backgroundColor: Colors.red,),
                            );
                          }
                        },
                        child: const Text('Buscar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (coordenates != null) ...[
            const SizedBox(height: 20),
            Column(
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: CustomInput(
                        label: 'Cidade',
                        keyboardType: TextInputType.text,
                        controller: cityController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: CustomInput(
                        label: 'Estado',
                        maxLength: 2,
                        keyboardType: TextInputType.text,
                        controller: ufController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                
                CustomInput(
                  label: 'Endereço',
                  keyboardType: TextInputType.text,
                  controller: addressController,
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: 'bairro',
                  keyboardType: TextInputType.text,
                  controller: neighborhoodController,
                ),
                const SizedBox(height: 20),               
                Text('Seu estabelecimento se encontra aqui:', 
                style: TextStyle(color:AppColors.secondary, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                SizedBox(
                  height: 300,
                  child: buildMap(
                    coordenates!,
                    () {},
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Verifica se o formulário é válido (todos os campos obrigatórios preenchidos)
                    if (_formKey.currentState!.validate()) {
                      final name = nameController.text;
                      final phone = phoneController.text;
                      final cep = cepController.text;
                      final city = cityController.text;
                      final uf = ufController.text;
                      final address = addressController.text;
                      final neighborhood = neighborhoodController.text;

                      // Aqui você pode continuar com o envio, salvar no banco de dados ou o que quiser
                      print('Novos dados da loja');
                      print('Nome: $name');
                      print('Telefone: $phone');
                      print('CEP: $cep');
                      print('Cidade: $city');
                      print('Estado: $uf');
                      print('Endereço: $address');
                      print('Bairro: $neighborhood');
                      print(coordenates?.latitude);
                      print(coordenates?.longitude);

                      Store newStore = Store(
                        id: widget.idStore,
                        storeName: name,
                        phone: phone,
                        cep: cep,
                        city: city,
                        uf: uf,
                        address: address,
                        neighborhood: neighborhood,
                        latitude: coordenates!.latitude,
                        longitude: coordenates!.longitude,
                      );

                      await _storeRepository.updateStore(newStore);
                      

                      // Exemplo de feedback visual
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Loja atualizada com realizado com sucesso!', 
                        style: TextStyle(color: Colors.white),), backgroundColor: Colors.green),
                      );

                      Navigator.pushNamed(context, '/store-details');

                      // Quando tver um backend
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => StoreDetail(id_store: '1'),
                      //   ),
                      // );
                    } else {
                      // Caso algum campo obrigatório esteja vazio
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, preencha todos os campos obrigatórios.', 
                          style: TextStyle(color: Colors.white),), 
                          backgroundColor: Colors.red),
                      );
                    }
                  },
                  child: const Text('Atualizar'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
