#!/bin/bash
# Run this script on the NAS to test that setup-server-folders.sh works.
# It creates /volume1/test as a dry-run target folder.

TEST_DIR="/volume1/test"

mkdir -p "$TEST_DIR"

if [ -d "$TEST_DIR" ]; then
  echo ""
  echo "SUCCESS: $TEST_DIR was created."
else
  echo ""
  echo "FAIL: $TEST_DIR was not created."
  exit 1
fi
