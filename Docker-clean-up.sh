#!/bin/bash

#ask about what do you want to do

line="-----------------------------------------------------------------------------------"
echo $line
read -p "Do you want to delete all images[i], all stoped containers[c] or both[b]?[i, c, b]" answer
echo $line
case $answer in
        i)
                cont_number=$(($(docker ps -a | wc -l) -1 ))
                cont_ID=$(sudo docker ps -a | tr -s ' ' | tr -s "\t" | cut -d ' ' -f 1 | tail -$(($(sudo docker ps -a | wc -l) - 1)) | tr ' ' $'\t')  
                for ID_number in $cont_ID; do 
                        sudo docker rm $ID_number
                done;;
        c)
                images_ID=$(sudo docker images | tail -$(($(sudo docker images | wc -l) - 1)) | tr $'\t' ' ' | tr -s ' ' | cut -d ' ' -f 3)
                for im_ID in $images_ID; do
                        sudo docker rmi $im_ID
                done;;
        b)
                cont_ID=$(sudo docker ps -a | tr -s ' ' | tr -s "\t" | cut -d ' ' -f 1 | tail -$(($(sudo docker ps -a | wc -l) - 1)) | tr ' ' $'\t')  
                images_ID=$(sudo docker images | tail -$(($(sudo docker images | wc -l) - 1)) | tr $'\t' ' ' | tr -s ' ' | cut -d ' ' -f 3)

                for ID_number in $cont_ID; do 
                        sudo docker rm $ID_number
                done;
                for im_ID in $images_ID; do
                        sudo docker rmi $im_ID
                done;;
        *) exit 0;;
esac

exit 0
