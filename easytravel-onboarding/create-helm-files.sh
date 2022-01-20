#!/bin/bash

echo "remove current tgz files...."
rm easytravel-angular.tgz
rm easytravel-www.tgz
rm easytravel-backend.tgz
rm easytravel-frontend.tgz
rm easytravel-mongodb.tgz

echo "Creating tgz files...."

tar -czvf easytravel-angular.tgz /easytravel-angular
tar -czvf easytravel-www.tgz /easytravel-www
tar -czvf easytravel-backend.tgz /easytravel-backend
tar -czvf easytravel-frontend.tgz /easytravel-frontend
tar -czvf easytravel-mongodb.tgz /easytravel-mongodb

echo "tarballs created...."
