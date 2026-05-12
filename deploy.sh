#!/bin/bash
set -e
echo "=== Deploying application ==="
DEPLOY_DIR="/opt/myapp"
sudo mkdir -p $DEPLOY_DIR
sudo cp target/myapp-1.0-SNAPSHOT.jar $DEPLOY_DIR/myapp.jar
sudo pkill -f 'myapp.jar' || true
sleep 2
nohup java -jar $DEPLOY_DIR/myapp.jar > $DEPLOY_DIR/app.log 2>&1 &
echo "Deployed successfully. PID: $!"
