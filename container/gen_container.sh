#!/usr/bin/env bash

if [ $# -ne 2 ]
then
   echo "you need to specify 2 parameter ..."
   echo "$0 IMAGE_NAME LOCAL_VERSION"
   exit 1
fi

# parameters from calling script
IMAGE_NAME=$1
LOCAL_VERSION=$2

#template name where versions will be based on
TEMPLATE=container/Dockerfile.template

#image variant
VARIANT="-slim"

# versions as folder names
VERSIONS=( */ )
VERSIONS=( "${VERSIONS[@]%/}" )

# function to inject Dockerfile header
dockerfile_header() {
	cat <<-EOH
		# NOTE: THIS DOCKERFILE IS GENERATED VIA "gen_dockerfile.sh"
		#
		# PLEASE DO NOT EDIT IT DIRECTLY.
	EOH
}

# sort version numbers with highest first
VSORT=$'\n'; VERSIONS=( $(echo "${VERSIONS[*]}" | sort -rV) ); unset VSORT

# process the versions to be build
for VERSION in "${VERSIONS[@]}"
do
  #process only version number files
  [ -d "$VERSION" -a "$VERSION" != "container" ] || continue

  echo "building ${IMAGE_NAME}-${VERSION} ..."

  # cleanup previous created files
  rm ./$VERSION/*

  #build the source image tag where docker images is based upon
  TAG=$VERSION$VARIANT

  # building variables for files used
  DOCKER_FILE_PATH="$VERSION/Dockerfile"
  PYVER_FILE="./${VERSION}/pyverfile"

  #copy the template incl. header
  { dockerfile_header; cat "$TEMPLATE"; } > "$DOCKER_FILE_PATH"

  # replace values in the template
  sed -ri ''\
          -e 's/^(FROM python):.*/\1:'"$TAG"'/' \
          "$DOCKER_FILE_PATH"

  # build the container
  docker build -t "${IMAGE_NAME}-${VERSION}:${LOCAL_VERSION}" -t "${IMAGE_NAME}-${VERSION}:latest-dev" . -f ./"${DOCKER_FILE_PATH}"

  # get the detailed version from the container and create a version file
  docker run -ti --rm --entrypoint /bin/bash "${IMAGE_NAME}-${VERSION}:${LOCAL_VERSION}" \
  -c 'python --version' > "${PYVER_FILE}"

  #todo: remove \r at the end of the filename
  mv "${PYVER_FILE}" ./${VERSION}/`tail -n 1 "${PYVER_FILE}" | sed 's/\\n/\n/g' | sed 's/ /_/g'`
done