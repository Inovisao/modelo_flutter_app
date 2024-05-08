# modelo_flutter_app

### Autores
- Fabio Prestes Cesar Rezende

Projeto de aplicativo utilizando framework Flutter. Atualmente baseando-se nas condicoes do projeto de Pano de Batida.
Aplicativo capaz de tirar ou escolher multiplas fotos, salva-las localmente no dispositivo, e envia-las para a API junto as informacoes da imagem e do usuario.

## Como usar

- Faca Login usando uma conta existente da Google;
- Pressione o icone de imagem para entrar na pagina de tirar fotos;
- Tire uma foto, ou selecione uma foto ja existente;
- Pressione o botao Upload, a imagem agora estara salva temporariamente no seu dispositivo;
- Pressione o icone de upload, as imagens previamente tiradas serao enviadas a API;
- Caso queira mudar de conta, pressione o icone de Logout no topo superior direito, e voce voltara a pagina de login;

## Setup

Para rodar o aplicativo, por favor siga as instrucoes para [instalar o Flutter e suas dependencias](https://docs.flutter.dev/get-started/install). Quaisquer duvidas sobre o processo, seja no Windows ou no Ubuntu, por favor entrar em contato com os autores do aplicativo.

Alem do Flutter, tambem sera necessario a instalacao do Android Studio (parte das dependencias instaladas para o Flutter). Este eh necessario para:
1. Criar um emulador de Android;
2. Permitir que aparelhos Android fisicos possam ser usados como aparelho destino;

Independente do metodo a ser usado, clone o projeto, e, a partir da pasta base do repositorio, siga as instrucoes a seguir:

1. No terminal, rode `flutter doctor` para garantir que todos os campos estejam ativados com sucesso;
2. Rode os seguintes comandos para limpar o projeto de quaisquer arquivos incompativeis com seu sistema, e remontar o projeto para seu sistema:
```
flutter clean
flutter pub get
```
- Sistema de login atualmente esta usando FirebaseAuth e Google Social Login, linkados a uma conta criada por Fabio Prestes. Por favor falar com Fabio para mais informacoes em como configurar essa parte.

3. O projeto esta pronto para ser rodado! Abra o arquivo `lib/main.dart` e rode-o fora do modo debug (CTRL + F5), usando o dispositivo desejado. 

Recomendado o uso do Visual Studio Code, para facilidade de troca de aparelho alvo. Atualmente temos os seguintes aparelhos compativeis:
- Linux;
- Android;

Para mudar o dispositivo sendo usado no VSCode, abra os comandos do Flutter usando CTRL + Shift + P (Atalho padrao), e procure por `Flutter: Select Device`. 

Varias opcoes de dispositivos estaram disponiveis, como o seu sistema operacional atual, o seu navegador escolhido como executavel do Chrome, e quaisquer simuladores que estiverem instalados e preparados na sua maquina.

Para rodar localmente durante desenvolvimento, sera necessario modificar a variavel `apiSendImageUrl` em `lib/widgets/request_handler.dart` para a URL da maquina onde a API esta rodando seguida da porta sendo usada. Este IP tambem deve ser configurado na API na variavel `ALLOWED_HOSTS`.

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


## Criando APKs
Todos os passos e sub-guias se encontram [na documentacao do Flutter e do Android](https://docs.flutter.dev/deployment/android). De interesse temos a mudanca do icone do projeto, assim como configurar os temas dia e noite do aplicativo, e explicacoes mais detalhadas de como assinar e criar a versao final dos apps.
Para criar uma APK, uma keystore (um arquivo chave) eh necessario.
1. Idealmente, para cada app, se tera um Keystore unico,e ele pode ser criado usando o seguinte comado:
Para Windows:
```
keytool -genkey -v -keystore model-inophoto-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias model-inophoto-mvp
```

Para Linux e macOS:
```
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

**_AVISO: O KEYSTORE GERADO ACIMA NAO DEVER SER COLCOADO JUINTO DO PROJETO, ELE DEVE SER IGNORADO OU SAVO EM OUTRO LOCAL_**

2. Em seguida, insira o caminho absoluto para o Keystore gerado para o seguinte local:
[nome_do_projeto]/android/key.properties
Informacoes a mudar:
```
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>
```

**_AVISO: O KEYSTORE FILE/STOREFILE ACIMA NAO DEVER SER COLOCADO JUNTO DO PROJETO, ELE DEVE SER IGNORADO OU SALVO EM OUTRO LOCAL_**

3. Configurando o gradle
### Criar versao release do aplicativo: [Modo App Bundle (recomendado para Play Store)](https://docs.flutter.dev/deployment/android#build-the-app-for-release):
 - Dentro da pasta principal (modelo_flutter_app):
```
flutter build appbundle
```
 - O app bundle eh criado dentro da pasta `modelo_flutter_app`/build/app/outputs/bundle/release/app.aab
 - Baixe a ferramenta (bundletool)[https://github.com/google/bundletool/releases/latest], crie as APKs a partir do App Bundle, e instale essas APKs nos dispositivos.

### Criar versao release do aplicativo: [Modo APK](https://docs.flutter.dev/deployment/android#build-an-apk):
- Se feito os passos anteriores, a APK ja estara assinada.
- Rode o seguinte comando para criar APKs de diferentes arquiteturas
```flutter build apk --split-per-abi```
- Os APKs resultantes se encontram nas seguintes pastas:
 - modelo_flutter_app/build/app/outputs/apk/release/app-armeabi-v7a-release.apk
 - modelo_flutter_app/build/app/outputs/apk/release/app-arm64-v8a-release.apk
 - modelo_flutter_app/build/app/outputs/apk/release/app-x86_64-release.apk