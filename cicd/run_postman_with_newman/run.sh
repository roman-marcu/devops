#/bin/bash

# stop on first error
set -e;

function onExit {
    if [ "$?" != "0" ]; then
        echo "Tests failed";
        # build failed, don't deploy
        exit 1;
    else
        echo "Tests passed";
        # deploy build
    fi
}

# call onExit when the script exits
trap onExit EXIT;

docker run -v "collections:/etc/newman" \
 -t romanmarcu/newman:alpinehtml \
 run sample.postman_collection.json --reporters cli,junit,htmlextra \
 --reporter-junit-export "newman_result.xml" \
 --reporter-htmlextra-export "newman_result.html" \
 --suppress-exit-code