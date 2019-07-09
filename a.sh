#!/bin/bash
message=${@:1}
message="\" $message \""
echo $message
