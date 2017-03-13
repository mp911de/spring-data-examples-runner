#!/usr/bin/env bash

MVN_ARGS=""

cd spring-data-examples

if [ ! -z ${DATA+x} ] ; then
  MVN_ARGS="${MVN_ARGS} -Dspring-data-releasetrain.version=${DATA} -pl !mongodb/reactive,!cassandra/reactive,!redis/reactive"
fi

if [ ! -z ${PROFILE+x} ] ; then
  MVN_ARGS="${MVN_ARGS} -P${PROFILE}"
fi

if [ ! -z ${BOOT+x} ] ; then
    mvn versions:update-parent -DgenerateBackupPoms=false -DallowSnapshots=true -DparentVersion="[${BOOT}]"
fi

echo "Running: mvn clean dependency:list test -Dsort -Dmaven.test.redirectTestOutputToFile=true -B ${MVN_ARGS}"
echo
mvn clean dependency:list test -Dsort -Dmaven.test.redirectTestOutputToFile=true -B ${MVN_ARGS}
