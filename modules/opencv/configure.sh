#!/bin/bash
set -e

# Give extra privileges to the default user so that it can use the webcam with OpenCV
usermod -a -G video default
