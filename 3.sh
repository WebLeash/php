#!/usr/bin/env bash

while getopts ":p:l:t:" option; do
    case "${option}" in
      p)
         p1=${OPTARG}
          ;;
      l)
          l1=${OPTARG}
              ;;
      t)
          t1=${OPTARG}
	  ;;
       *)
          usage
	  ;;
    esac
done

echo "p=$p1 l=$l1 t=$t1"