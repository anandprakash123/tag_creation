#!/bin/bash

npm run lint:ci
if [ $? -ne 0 ]; then
  exit 1  # Exit with non-zero status code if lint:ci command fails
fi

npm run test:unit
if [ $? -ne 0 ]; then
  exit 1  # Exit with non-zero status code if test:unit command fails
fi
