echo Downloading scripts...
mkdir ~/.web > t.txt
mkdir ~/.web/tubs > t.txt
rm -rf t.txt
echo Downloading build.sh
echo
curl --silent https://raw.githubusercontent.com/Gum-Joe/Web-OS-container/master/dist/build.sh -o ~/.web/tubs/build.sh
echo Downloading run.sh...
echo
curl --silent https://raw.githubusercontent.com/Gum-Joe/Web-OS-container/master/dist/run.sh -o ~/.web/tubs/run.sh
