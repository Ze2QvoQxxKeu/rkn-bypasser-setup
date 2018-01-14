#define MyAppName "RKN bypasser"
#define MyAppVersion "0.3"
#define MyAppPublisher "dimuls@yandex.ru & adm1n1strat1on@list.ru"
#define MyAppURL "https://github.com/someanon/rkn-bypasser"
#define MyAppExeName "rkn-bypasser-x64.exe"

[Setup]
AppId={{A6EF4A49-C0C4-4F70-AC86-F274E94CC68F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=D:\Soft\rkn-bypasser\license.txt
OutputBaseFilename=setup
SetupIconFile=D:\Soft\rkn-bypasser\icon.ico
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Files]
Source: "D:\Soft\rkn-bypasser\nssm-x64.exe"; DestDir: "{app}"; DestName: "nssm.exe"; Check: Is64BitInstallMode; Flags: ignoreversion
Source: "D:\Soft\rkn-bypasser\nssm-x32.exe"; DestDir: "{app}"; DestName: "nssm.exe"; Check: not Is64BitInstallMode; Flags: ignoreversion
Source: "D:\Soft\rkn-bypasser\ClientConf"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Soft\rkn-bypasser\roots"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Soft\rkn-bypasser\rkn-bypasser-x64.exe"; DestDir: "{app}"; DestName: "rkn-bypasser.exe"; Check: Is64BitInstallMode; AfterInstall: InstallService; Flags: ignoreversion
Source: "D:\Soft\rkn-bypasser\rkn-bypasser-x32.exe"; DestDir: "{app}"; DestName: "rkn-bypasser.exe"; Check: not Is64BitInstallMode; AfterInstall: InstallService; Flags: ignoreversion
Source: "C:\Program Files (x86)\The Road To Delphi\VCL Styles Inno\VclStylesinno.dll"; DestDir: {app}; Flags: dontcopy
Source: "C:\Program Files (x86)\The Road To Delphi\VCL Styles Inno\Styles\OnyxBlue.vsf"; DestDir: {app}; Flags: dontcopy

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

[UninstallRun]
Filename: "{app}\nssm.exe"; Parameters: "stop RKN-bypasser";
Filename: "{app}\nssm.exe"; Parameters: "remove RKN-bypasser confirm";

[Code]
procedure LoadVCLStyle(VClStyleFile: String); external 'LoadVCLStyleW@files:VclStylesInno.dll stdcall';
procedure UnLoadVCLStyles; external 'UnLoadVCLStyles@files:VclStylesInno.dll stdcall';
 
function InitializeSetup(): Boolean;
begin
  ExtractTemporaryFile('OnyxBlue.vsf');
  LoadVCLStyle(ExpandConstant('{tmp}\OnyxBlue.vsf'));
  Result := True;
end;
 
procedure DeinitializeSetup();
begin
  UnLoadVCLStyles;
end;

procedure InstallService();
var
  ResultCode: Integer;
begin
  Exec(ExpandConstant('{app}\nssm.exe'), 'install RKN-bypasser "' + ExpandConstant('{app}\rkn-bypasser.exe') +'"', ExpandConstant('{app}\'), SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec(ExpandConstant('{app}\nssm.exe'), 'set RKN-bypasser DisplayName "RKN bypasser"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec(ExpandConstant('{app}\nssm.exe'), 'set RKN-bypasser Description "Прокси-сервер для обхода блокировок РосКомНадзора. Для использования укажите в нужном приложении тип прокси Socks5, сервер 127.0.1.1 и порт 8000"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec(ExpandConstant('{app}\nssm.exe'), 'set RKN-bypasser Start SERVICE_AUTO_START', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec(ExpandConstant('{app}\nssm.exe'), 'start RKN-bypasser', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
end;
