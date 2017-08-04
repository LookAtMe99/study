#define MyAppName "Jack"
#define MyAppVersion "v1.0"
#define MyDefaultFolderName "Sample"


[Setup]
AppId={{cf5562ba-058f-4c41-992c-3fdc962c3445}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppName}
DefaultDirName={pf}\{#MyDefaultFolderName}
DefaultGroupName={#MyDefaultFolderName}
VersionInfoVersion={#MyAppVersion}
VersionInfoCopyright=Copyright @ {#MyAppName}
AllowNoIcons=yes
OutputDir=Server
OutputBaseFilename={#MyAppName} {#MyAppVersion}
Compression=lzma
SolidCompression=yes
UsePreviousAppDir=no
DisableDirPage=yes
ArchitecturesInstallIn64BitMode=x64
RestartIfNeededByRun=yes
AppCopyright={#MyAppName}
PrivilegesRequired=Admin
AlwaysRestart=yes

[Languages]
Name: en; MessagesFile: compiler:Default.isl
Name: ko; MessagesFile: compiler:Languages\Korean.isl

[Messages]
en.BeveledLabel=English
ko.BeveledLabel=Korean

[Files]
Source: "재배포패키지"

[Run]
Filename: "재배포패키지 설치"

[Code]
function NoRedistributable_VC2005x86(): boolean;
begin
  result := not RegKeyExists(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{7299052b-02a4-4627-81f2-1818da5d550d}')
end;

function NoRedistributable_VC2005x64(): boolean;
begin
  result := not RegKeyExists(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{071c9b48-7c32-4621-a0ac-3f809523288f}')
end;

function NoRedistributable_VC2008x86(): boolean;
begin
  result := not RegKeyExists(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{9A25302D-30C0-39D9-BD6F-21E6EC160475}')
end;

function NoRedistributable_VC2008x64(): boolean;
begin
  result := not RegKeyExists(HKLM, ' SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{8220EEFE-38CD-377E-8595-13398D740ACE}')
end;

function NoRedistributable_VC2010x86(): boolean;
begin
  result := not RegKeyExists(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{F0C3E5D1-1ADE321E-8167-68EF0DE699A5}')
end;

function NoRedistributable_VC2010x64(): boolean;
begin
  result := not RegKeyExists(HKLM, ' SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{1D8E6291-B0D5-35EC-8441-6616F567A0F7}')
end;
