
#!/user/env/bin/bash
chmod +x build/*

echo "Building docker"
build/build_docker.sh $1

echo "Building go"
build/build_go.sh

echo "All done!"
