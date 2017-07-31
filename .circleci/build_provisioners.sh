#!/bin/sh
for provisioner in *-provisioner ; do
    LATEST_COMMIT=$(git rev-parse HEAD)
    PROVISIONER_COMMIT=$(git log -1 --format=format:%H --full-diff ${provisioner})
    
    build_count=0

    # trigger a build if the latest commit matches the provisioner
    # and CircleCI configuration exists for the provisioner
    if [[ "${LATEST_COMMIT}" ==  "${PROVISIONER_COMMIT}" ]] \
    && grep -q ${provisioner} .circleci/config.yml ; then

        echo Triggering build of ${provisioner}.
        build_count += 1

        curl -s \
        --user ${CIRCLE_API_TOKEN}: \
        --data build_parameters[CIRCLE_JOB]=${provisioner} \
        --data revision=${CIRCLE_SHA1} \
        https://circleci.com/api/v1.1/project/github/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/tree/${CIRCLE_BRANCH}

    fi

    if [[ "${build_count}" == 0 ]] ; then
        echo No builds triggered.
    fi

done