#!/bin/bash
# BFS Script

sleep 2
echo "Enable Unbuffered logging on FMS"
ontape -s -L 0 -U fms
sleep 2
echo "Enable Unbuffered logging on BAT"
ontape -s -L 0 -U bat

