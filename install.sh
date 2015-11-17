echo Downloading scripts...
mkdir ~/.boss > t.txt
mkdir ~/.boss/tubs > t.txt
rm -rf t.txt
echo Downloading build.sh
echo
curl --silent https://raw.githubusercontent.com/Gum-Joe/Web-OS-container/master/dist/build.sh -o ~/.boss/tubs/build.sh
echo Downloading run.sh...
echo
curl --silent https://raw.githubusercontent.com/Gum-Joe/Web-OS-container/master/dist/run.sh -o ~/.boss/tubs/run.sh
