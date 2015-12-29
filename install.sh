echo Downloading scripts...
mkdir ~/.jakhu > t.txt
mkdir ~/.jakhu/tubs > t.txt
rm -rf t.txt
echo Downloading build.sh
echo
<<<<<<< HEAD
curl --silent https://raw.githubusercontent.com/Gum-Joe/jakhu-container/master/dist/build.sh -o ~/.web/tubs/build.sh
echo Downloading run.sh...
echo
curl --silent https://raw.githubusercontent.com/Gum-Joe/jakhu-container/master/dist/run.sh -o ~/.web/tubs/run.sh
=======
curl --silent https://raw.githubusercontent.com/Gum-Joe/jakhu-container/master/dist/build.sh -o ~/.jakhu/tubs/build.sh
echo Downloading run.sh...
echo
curl --silent https://raw.githubusercontent.com/Gum-Joe/jakhu-container/master/dist/run.sh -o ~/.jakhu/tubs/run.sh
>>>>>>> origin/master
