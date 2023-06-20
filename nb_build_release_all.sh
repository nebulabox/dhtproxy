#!/usr/bin/env sh
set -x
NAME=dhtproxy 
SRC="." 

rm -rf ./release

CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build                     -o release/${NAME}_darwin_amd64 ${SRC}                 
CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build                     -o release/${NAME}_darwin_arm64 ${SRC}                                
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build                      -o release/${NAME}_linux_amd64 ${SRC}                 
CGO_ENABLED=0 GOOS=linux GOARCH=386 go build                        -o release/${NAME}_linux_386 ${SRC}                              
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build                      -o release/${NAME}_linux_arm64 ${SRC}                 
CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build                -o release/${NAME}_linux_arm7 ${SRC}              
CGO_ENABLED=0 GOOS=linux GOARCH=mipsle go build                     -o release/${NAME}_linux_mipsle ${SRC}                            
CGO_ENABLED=0 GOOS=linux GOARCH=mipsle GOMIPS=softfloat go build    -o release/${NAME}_linux_mipsle_softfloat ${SRC}                  

pushd release
for entry in *
do
  echo "Packing : ${entry%.*}.tar.xz"
  COPYFILE_DISABLE=1 tar cvfJ ${entry%.*}.tar.xz $entry && rm $entry
done
popd
