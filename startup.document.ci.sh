#!/usr/bin/env bash
set -e

/opt/wait-for-it.sh mongo:27017
npm run seed:run:document
npm run start:prod > /dev/null 2>&1 &
/opt/wait-for-it.sh maildev:1080
/opt/wait-for-it.sh localhost:3456
npm run lint
npm run test:e2e -- --runInBand
