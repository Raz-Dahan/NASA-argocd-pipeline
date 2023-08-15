#!/bin/bash

echo "apiVersion: v2
name: nasa-app
version: 1.$BUILD_NUMBER.0
description: A Helm chart for deploying Flask and Redis" > Chart.yaml

echo "TAG: v1.$BUILD_NUMBER" > values.yaml
