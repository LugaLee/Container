#!/bin/bash
#  K3d's registry with images from the local registry

registryLabel="k3d-book-registry"
registryPort=$( docker ps -f name=k3d-book-registry | grep -o ":[0-9]*->5000" | sed 's/:\([^-]*\)-.*/\1/' )

if [[ "$registryPort" == "" ]] ; then
    echo "ERROR: Unable to find k3d registry to connect to!"
    exit 1
fi

declare -a images=(
    "guzo/book-testdata"
)

for image in "${images[@]}" ; do
    imageName=$( echo $image | cut -d'/' -f2 )
    newTag="${registryLabel}.localhost:${registryPort}/${imageName}:local"
    docker tag ${image} ${newTag}
    docker push ${newTag}
    docker rmi ${newTag}
done
