#ifndef MyBuildNumber
	#define MyBuildNumber "0"
#endif
#define PackageVersion "v" + MyBuildNumber

[Setup]
AppId={{74ED678D-C72A-49D8-8B3D-495CD8EBE539}
AppName=Sample
AppVersion={#PackageVersion}
AppVerName=Sample
AppPublisher=Jack
DefaultDirName={pf}\Sample
DefaultGroupName=Jack
VersionInfoVersion={#PackageVersion}
VersionInfoCopyright=Copyright @ Jack
AllowNoIcons=yes
OutputDir=Output
OutputBaseFilename=Sample
DisableDirPage=yes
PrivilegesRequired=Admin
RestartIfNeededByRun=yes
DisableWelcomePage=yes
DisableProgramGroupPage=yes
DisableFinishedPage=yes
ArchitecturesInstallIn64BitMode=x64
AppCopyright=Jack

[Icons]
Name: "{group}\nowizard\Uninstall"; Filename: {uninstallexe}

[Files]
;sample file
Source: .\*; Excludes: "*.md"; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs; 

[Run]

[UninstallRun]

[Code]
const
  BN_CLICKED = 0;
  WM_COMMAND = $0111;
  CN_BASE = $BC00;
  CN_COMMAND = CN_BASE + WM_COMMAND;

procedure CurPageChanged(CurPageID: Integer);
var
  Param: Longint;
begin
  // if we are on the ready page, then...
  if CurPageID = wpReady then
  begin
    // the result of this is 0, just to be precise...
    Param := 0 or BN_CLICKED shl 16;
    // post the click notification message to the next button
    PostMessage(WizardForm.NextButton.Handle, CN_COMMAND, Param, 0);
  end;
end;