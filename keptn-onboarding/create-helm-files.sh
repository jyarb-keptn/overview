#!/bin/bash

echo "remove current tgz files...."
rm order.tgz
rm frontend.tgz
rm customer.tgz
rm catalog.tgz

echo "Creating tgz files...."

tar -czvf order.tgz order
tar -czvf frontend.tgz frontend
tar -czvf customer.tgz customer
tar -czvf catalog.tgz catalog

echo "tarballs created...."