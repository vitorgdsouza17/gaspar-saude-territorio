# Gaspar Saúde Território — protótipo 0.1

**Somente demonstração com dados fictícios.** Não há integração com e-SUS APS PEC, autenticação ou armazenamento offline.

## Windows 11: requisitos

Instale Python 3.11+, Git, Flutter SDK, Android Studio (Android SDK + emulador) e VS Code com extensões Flutter/Dart.

Execute `flutter doctor` e `flutter doctor --android-licenses`.

## Executar backend (PowerShell)
```powershell
cd backend
py -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -m uvicorn main:app --host 127.0.0.1 --port 8000 --reload
```
Abra http://127.0.0.1:8000/docs e http://127.0.0.1:8000/health.

## Executar app Android (outro terminal)
```powershell
cd flutter_app
flutter create --platforms=android --project-name gaspar_saude_territorio .
flutter pub get
flutter devices
flutter run
```
O emulador Android acessa o host pelo endereço `http://10.0.2.2:8000`. Se `flutter create` reescrever AndroidManifest.xml, mantenha a permissão INTERNET e a opção de cleartext HTTP **apenas para desenvolvimento local**.

No dispositivo físico, ajuste backend e firewall na rede local e use `flutter run --dart-define=API_BASE_URL=http://IP_DO_PC:8000`. Nunca exponha a API demo à internet.

## Próximos passos

Autenticação, banco offline criptografado, sincronização com fila e idempotência, backend com PostgreSQL, HTTPS, controle por microárea e auditoria. A integração ao PEC e substituição do aplicativo oficial dependem de interfaces **autorizadas e documentadas** de leitura e envio (LEDI). Não introduzir dados reais ou segredos até testes homologados.
