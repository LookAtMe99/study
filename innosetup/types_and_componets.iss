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

; Type을 OS로 구분
; OS로 구분 시 User 입장에서는 보기 좋을 지 몰라도 중복적인 내용을 다 명시해야 해서 효율적이진 않음
; type & component가 flag custome 없이 1:1로 맵핑 시 install 화면에서는 드롭다운 메뉴로 노출됨
[Types] 
Name: Windows7; Description: 01. To install on Windows7
Name: Windows8; Description: 02. To install on Windows8
Name: Windows10; Description: 03. To install on Windows10
Name: Server2008; Description: 04. To install on Server2008
Name: Server2012; Description: 05. To install on Server2012

[Components]
Name: Windows7; Description: 01. To install on Windows7; Types: Windows7
Name: Windows8; Description: 02. To install on Windows8; Types: Windows8
Name: Windows10; Description: 03. To install on Windows10; Types: Windows10
Name: Server2008; Description: 04. To install on Server2008; Types: Server2008
Name: Server2012; Description: 05. To install on Server2012; Types: Server2012

[Files]
Source: "file1" Components: Windows7 Windows8 Windows10 Server2008 Server2012;
Source: "file2" Components: Windows10;
Source: "file3" Components: Windows8 Server2012;

[Run]
Filename: "file1 install" Components: Windows7 Windows8 Windows10 Server2008 Server2012;
Filename: "file2 install" Components: Windows10;
Filename: "file3 install" Components: Windows8 Server2012;


; Type을 Application으로 구분
; User 입장에서는 잘 모르니까 항상 Full로 설치하지 않을까... Description만 잘 정의한다면 User가 원하는 내용으로 설치 가능
; install 화면에서는 체크박스 형태로 노출됨
; windows version 별로 설치되야 하는 경우는 OnlyBelowVersion, MinVersion 등 Windows version을 체크하는 옵션을 활용한다
[Types] 
Name: "full"; Description: "Full";
Name: "app1"; Description: "Application1";
Name: "app2" Description: "Application2";
Name: "custom"; Description: "Custom"; Flags: iscustom;

[Components]
Name: "application1"; Description: "Application1"; Types: full app1;
Name: "application2"; Description: "Application2"; Types: full app2;
Name: "sub"; Description: "Support Application"; Types: full;

[Files]
Source: "file1" Components: application1;
Source: "file2" Components: application2;
Source: "file3" Components: sub;

[Run]
Filename: "file1 install" Components: application1;
Filename: "file2 install" Components: application2; OnlyBelowVersion: 6.2
Filename: "file3 install" Components: sub;


