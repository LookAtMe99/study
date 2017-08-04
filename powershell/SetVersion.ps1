# SetVersion.ps1
#
# Set the version in all the AssemblyInfo.cs or AssemblyInfo.vb files in any subdirectory.
#
# usage:  
#  from cmd.exe: 
#     powershell.exe SetVersion.ps1  <Projectname>
# 
#  from powershell.exe prompt: 
#     .\SetVersion.ps1  <Projectname>
#

function Update-SourceVersion
{
  [string]$Version= get-content $ver_dir$verinfo
  $NewVersion = 'AssemblyVersion("' + $Version + '")';
  $NewFileVersion = 'AssemblyFileVersion("' + $Version + '")';
    
  foreach ($o in $input) 
  {
    Write-output $o.FullName
    $TmpFile = $o.FullName + ".tmp"

     get-content $o.FullName |
		%{$_ -replace 'AssemblyVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $NewVersion } |
		%{$_ -replace 'AssemblyFileVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $NewFileVersion }  > $TmpFile
		

     move-item $TmpFile $o.FullName -force
  }
}

function Update-AllAssemblyInfoFiles ( $version )
{
  foreach ($file in "AssemblyInfo.cs", "AssemblyInfo.vb") 
  {
    get-childitem -recurse |? {$_.Name -eq $file} | Update-SourceVersion $version ;
  }
}

$project = $args[0] 									#args에는 jenkins project name을 사용
$dir = "D:\Jenkins\jobs\$project\"						# jenkins path
$versionFile = "D:\Jenkins\version.txt"					# version file path								
$buildinfo="5"											# sample
$state_file = get-content -path $dir$buildinfo
$next_version = $state_file
[int]$build_version = $next_version
$build_version--
$version_string = "ver" + $build_version
Set-Content $versionFile $version_string

$args= get-content $versionFile
$args= get-content $ver_dir$verinfo
Update-AllAssemblyInfoFiles $args;