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
  version_expected = "python-3.6.2"
  echo "$version_expected" > ${ENV_DIR}/PYTHON_VERSION_OVERRIDE
  capture ${BUILDPACK_HOME}/bin/compile ${BUILD_DIR} ${CACHE_DIR} ${ENV_DIR}

  assertEquals 0 ${rtrn}
  assertEquals "" "`cat ${STD_ERR}`"
  assertEquals "Checking for PYTHON_VERSION_OVERRIDE\nOverriding Python version to $version_expected" "`cat ${STD_OUT}`"
  assertEquals "$version_expected" "`cat ${BUILD_DIR}/runtime.txt`"
}
