#/bin/bash


DOCKER_REPO='razdahan31/gha-pipeline'
if [[ "$1" == "--no-rename" ]]; then
    NEW_TAG=$(curl -s "https://hub.docker.com/v2/repositories/${DOCKER_REPO}/tags" | jq -r '.results[0].name')
    echo "NEW_TAG=$NEW_TAG"
    exit 0
fi

LAST_COMMIT=$(git log -1 --pretty=%B)

DOCKER_REPO='razdahan31/gha-pipeline'
LATEST_TAG=$(curl -s "https://hub.docker.com/v2/repositories/${DOCKER_REPO}/tags" | jq -r '.results[0].name')

ARRAY=($(echo "$LATEST_TAG" | awk -F. '{print $1" "$2" "$3}'))
MAJOR=${ARRAY[0]}
MINOR=${ARRAY[1]}
PATCH=${ARRAY[2]}

if [[ "${LAST_COMMIT,,}" == "major" ]]; then
    MAJOR=$((MAJOR + 1))
elif [[ "${LAST_COMMIT,,}" == "minor" ]]; then
    MINOR=$((MINOR + 1))
else
    PATCH=$((PATCH + 1))
fi


NEW_TAG=$MAJOR.$MINOR.$PATCH

echo $NEW_TAG
