set -ex
# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=
# image name
IMAGE=
# get latest version from build-history.txt
tmpVersion=`tail -1 ./build-history.txt  | cut -d ' ' -f 2-`
version=`if [ "$tmpVersion" == "" ]; then echo "1.0"; else echo $tmpVersion; fi`
currentSubVersion=`echo $version | cut -d '.' -f2`
currentBaseVersion=`echo $version | cut -d '.' -f1`
nextVersion=`if [ "$currentSubVersion" == "20" ]; then echo "$((currentBaseVersion+1)).0"; else echo "$((currentBaseVersion)).$((currentSubVersion + 1))"; fi`
nextVersion=`if [ "$tmpVersion" == "" ]; then echo "1.0"; else echo $nextVersion; fi`
# run build
docker build -t $USERNAME/$IMAGE:$nextVersion .
# push it
docker push $USERNAME/$IMAGE:$nextVersion
echo "$(date +%s) $nextVersion" >> ./build-history.txt
