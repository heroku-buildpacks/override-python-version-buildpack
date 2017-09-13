#!/bin/bash

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testCompile()
{

  capture ${BUILDPACK_HOME}/bin/compile ${BUILD_DIR} ${CACHE_DIR} ${ENV_DIR}
  assertEquals 0 ${rtrn}
  assertEquals "" "`cat ${STD_ERR}`"
  expected_output=$(cat <<EOF
Checking for PYTHON_VERSION_OVERRIDE
No PYTHON_VERSION_OVERRIDE found
EOF
)
    assertEquals "$expected_output" "`cat ${STD_OUT}`"
}

testCompileWithPythonVersionOverride()
{
  echo "python-3.6.2" > ${ENV_DIR}/PYTHON_VERSION_OVERRIDE
  capture ${BUILDPACK_HOME}/bin/compile ${BUILD_DIR} ${CACHE_DIR} ${ENV_DIR}

  assertEquals 0 ${rtrn}
  assertEquals "" "`cat ${STD_ERR}`"
  expected_output=$(cat <<EOF
Checking for PYTHON_VERSION_OVERRIDE
Overriding Python version to python-3.6.2
EOF
)
  assertEquals "$expected_output" "`cat ${STD_OUT}`"
  assertEquals "python-3.6.2" "`cat ${BUILD_DIR}/runtime.txt`"
}
