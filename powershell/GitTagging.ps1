# git commit & push for delopy version tagging

$repository_path = $args[0]
$branch = $args[1]

$ver_dir= "D:\jenkins"								# �������� ���
$verinfo="version.txt"								# �������� ��ϵ� ����

$ver=get-content -path $ver_dir$verinfo

git tag "v$ver"
git push origin "v$ver"
