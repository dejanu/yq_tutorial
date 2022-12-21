#!/usr/bin/env bash

# ad-hoc yml linter as alias
#alias ymllint='python -c "import sys,yaml as y;y.safe_load(open(sys.argv[1]))"'

# display to stdout the script usage
function usage() {
    echo "Usage: $0 [options] [file]"
    echo "Options:"
    echo "  -h, --help: ask @dejanualex for help"
    echo "  -c, --content <file> : outputs the content of the yaml file"
    echo "  -k, --keys <file>: outputs the keys of the yaml file"
    echo "  -v, --values <file>: outputs the values of the yaml file"
    echo "  -kv, --keyvalue <file> <key_name>: get the value of the key"
    echo " -vr, --valuereplace <file> <key_name> <value>: replace the value of the key"
}


# if script only has one argument, display the usage
if [ $# -eq 1 ]; then
    usage
    exit 1
fi

# get the yaml file as an second argument and check if it is valid
file=$2
if [[ $file == *.yaml ]] || [[ $file == *.yml ]]; then
    # check if the file is valid
    if [[ $(yamllint $file) ]]; then
        echo "The argument is a valid yaml file"
    else
        echo "The argument is NOT a valid yaml file"
        exit 1
    fi
else
    echo "The file is not a yaml file"
    exit 1
fi

# if the first option is -c, --content, display the content of the yaml file
if [ $1 == "-c" ] || [ $1 == "--content" ]; then
    yq eval $file
fi

# if the first option is -k, --keys, display the keys of the yaml file
if [ $1 == "-k" ] || [ $1 == "--keys" ]; then
    yq 'to_entries | .[] | .key' $file
fi

# if the first option is -v, --values, display the values of the yaml file
if [ $1 == "-v" ] || [ $1 == "--values" ]; then
    yq 'to_entries | .[] | .value' $file
fi


if [ $1 == "-kv" ] || [ $1 == "--keyvalue" ]; then
    # check if the number of arguments is less than 3
    if [ $# -lt 3 ]; then
        echo "The key name is missing"
        exit 1
    fi
    yq 'to_entries | .[] | select(.key == "'$3'") | .value' $file
fi

# if the first option is -vr, --valuereplace, replace the value of the key
if [ $1 == "-vr" ] || [ $1 == "--valuereplace" ]; then
    if [ $# -lt 4 ]; then
        echo "The key name or the value is missing"
        exit 1
    fi
    #yq -i 'to_entries | .[] | select(.key == "'$3'") | .value = "'$4'"' $file
    yq -i '."'$3'" = "'$4'"' $file
fi