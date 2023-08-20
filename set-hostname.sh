#!/bin/sh
HOSTNAME=${1:?}
scutil --set HostName "$HOSTNAME"
scutil --set LocalHostName "$HOSTNAME"
scutil --set ComputerName "$HOSTNAME"
