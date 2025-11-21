
#!/user/env/bin/bash
chmod +x build/*

echo "Building docker"
build/build_docker.sh

echo "Building go"
build/build_go.sh

echo "All done!"
