# git commit & push for delopy version tagging

$repository_path = $args[0]
$branch = $args[1]

$ver_dir= "D:\jenkins"								# 버전정보 경로
$verinfo="version.txt"								# 버전정보 기록된 파일

$ver=get-content -path $ver_dir$verinfo

git tag "v$ver"
git push origin "v$ver"
