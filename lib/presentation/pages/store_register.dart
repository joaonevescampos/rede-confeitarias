import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';
import 'package:rede_confeitarias/models/store_model.dart';
import 'package:rede_confeitarias/presentation/blocs/store/store_bloc.dart';
import 'package:rede_confeitarias/presentation/blocs/store/store_event.dart';
import 'package:rede_confeitarias/presentation/blocs/store/store_state.dart';
import 'package:rede_confeitarias/presentation/components/custom_drawer.dart';
import 'package:rede_confeitarias/presentation/components/custom_input.dart';
import 'package:rede_confeitarias/presentation/components/map.dart';
import 'package:rede_confeitarias/services/cep_service.dart';

class StoreRegister extends StatefulWidget {
  const StoreRegister({super.key});

  @override
  State<StoreRegister> createState() => _StoreRegisterState();
}

class _StoreRegisterState extends State<StoreRegister> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final cepController = TextEditingController();
  final phoneController = TextEditingController();
  final adressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final neighborhoodController = TextEditingController();
  LatLng? coordenates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomDrawer(),
      body: BlocListener<StoreBloc, StoreState>(
        listener: (context, state) {
          if (state is StoreLoading) {
            // Exibir um carregamento durante a criação da loja
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Carregando...')),
            );
          } else if (state is StoreLoaded) {
            // Redirecionar para a página de detalhes da loja
            Navigator.pushNamed(
              context,
              '/store-details',
              arguments: state.store?.id, // Passando o id da loja criada
            );
          } else if (state is StoreError) {
            // Exibir erro caso a criação falhe
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro: ${state.message}')),
            );
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Cadastro da Confeitaria',
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
                              adressController.text = data['logradouro'] ?? '';
                              cityController.text = data['cidade'] ?? '';
                              stateController.text = data['estado'] ?? '';
                              neighborhoodController.text = data['bairro'] ?? '';

                              final coords = await searchCoordenates(
                                cep: cep,
                                cidade: data['cidade'] ?? '',
                                estado: data['estado'] ?? '',
                                logradouro: data['logradouro'] ?? '',
                              );

                              print('Coordenadas: $coords');

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
                          controller: stateController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  CustomInput(
                    label: 'Endereço',
                    keyboardType: TextInputType.text,
                    controller: adressController,
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
                    onPressed: () {
                      // Verifica se o formulário é válido
                      if (_formKey.currentState!.validate()) {
                        final name = nameController.text;
                        final phone = phoneController.text;
                        final cep = cepController.text;
                        final city = cityController.text;
                        final state = stateController.text;
                        final address = adressController.text;
                        final neighborhood = neighborhoodController.text;

                        // Chama o evento do BLoC para criar a loja
                        BlocProvider.of<StoreBloc>(context).add(
                          CreateStoreEvent(
                            store: Store(
                              storeName: name,
                              phone: phone,
                              cep: cep,
                              city: city,
                              uf: state,
                              address: address,
                              neighborhood: neighborhood,
                              latitude: coordenates!.latitude,
                              longitude: coordenates!.longitude,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Por favor, preencha todos os campos obrigatórios.')),
                        );
                      }
                    },
                    child: const Text('Cadastrar'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
