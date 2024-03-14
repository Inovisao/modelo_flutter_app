# modelo_flutter_app

### Autores
- Fabio Prestes Cesar Rezende

Projeto de aplicativo utilizando framework Flutter. Atualmente baseando-se nas condicoes do projeto de Pano de Batida.

## Setup

Para rodar o aplicativo, por favor siga as instrucoes para [instalar o Flutter e suas dependencias](https://docs.flutter.dev/get-started/install). Quaisquer duvidas sobre o processo, seja no Windows ou no Ubuntu, por favor entrar em contato com os autores do aplicativo.

Alem do Flutter, tambem sera necessario a instalacao do Android Studio (parte das dependencias instaladas para o Flutter). Este eh necessario para:
1. Criar um emulador de Android;
2. Permitir que aparelhos Android fisicos possam ser usados como aparelho destino;

Independente do metodo a ser usado, clone o projeto, e, a partir da pasta base do repositorio, siga as instrucoes a seguir:

1. No terminal, rode `flutter doctor` para garantir que todos os campos estejam ativados com sucesso;
2. Rode os seguintes comandos para limpar o projeto de quaisquer arquivos imcompativeis com seu sistema, e remontar o projeto para seu sistema:
```
flutter clean
flutter pub get
```
3. O projeto esta pronto para ser rodado! Abra o arquivo `lib/main.dart` e rode-o fora do modo debug (CTRL + F5), usando o dispositivo desejado. 

Recomendado o uso do Visual Studio Code, para facilidade de troca de aparelho alvo. Atualmente temos os seguintes aparelhos compativeis:
- Linux;
- Android;
- Windows (Necessita instalacao de pacotes extras);

Para mudar o dispositivo sendo usado no VSCode, abra os comandos do Flutter usando CTRL + Shift + P (Atalho padrao), e procure por `Flutter: Select Device`. 

Varias opcoes de dispositivos estaram disponiveis, como o seu sistema operacional atual, o seu navegador escolhido como executavel do Chrome, e quaisquer simuladores que estiverem instalados e preparados na sua maquina.

Futuramente, APKs e executaveis serao disponibilizados via a aba de Releases.

## Hierarquia de pastas

As Pastas deste projeto seguem o modelo base de novos projetos do Flutter. A seguir, estao detalhados as pastas e arquivos de importancia para desenvolvimento geral; Para situacoes mais especificas (como instalacao de certas bibliotecas e habilitacao de certas funcoes), verifique as instrucoes da dependencia ou a [documentacao geral do FLutter](https://docs.flutter.dev/):

- `modelo_flutter_app/`: Pasta root do projeto;
    - `pubspec.yaml`: arquivo contendo a lista de dependencias e assets do aplicativo;
    - `.gitignore`: .gitignore automaticamente gerado pelo Flutter, impede que repositorios do Git salvem arquivos muito instaveis ou grandes, como as APKs de teste/debug criadas durante uma run do projeto;
    - `android/`: Pasta contendo varias dependencias e permissoes esepcificas do Android; Automaticamente limpa pelo `.gitignore`;
    - `ios/`: Mesma funcao a pasta `android/`, porem para aparelhos iOS;
    - `build/`: Pasta contendo as builds de teste/debug do projeto. Automaticamente limpa pelo `.gitignore`;
    - `lib/`: Pasta contendo todos os codigos `*.dart` que fazem parte do projeto.
        - `main.dart`: Arquivo principal do projeto. Este eh rodado e comeca o aplicativo;
        - `screens/`: Arquivos que constroem as telas vistas pelo usuario;
        - `widgets/`: Arquivos que contem uma ou mais funcoes ou widgets complexos, usados em um ou mais lugares, para melhor leitura do codigo;
        - `models/`: Arquivos que servem como base de objetos usados pelo programa;
        - `providers/`: Arquivos que montam e mantem a database local de imagens nao postadas online, e futuramente permitira enviar tais imagens a API;