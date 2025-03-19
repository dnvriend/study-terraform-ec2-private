#!/bin/bash
# port forward local port 8080 to remote port 80
ssh i-0cada52cf6dca24b0 -fNT -4 -L 8080:localhost:80