# yq_tutorial

[yaml.org](https://yaml.org/)

### Wrapper usage:

```bash
# check the content of the yaml file
./yqyml_gen.sh -c <file>

# outputs the keys of the yaml file
./yqyml_gen.sh -k <file>

# get the value of the key
./yqyml_gen.sh -kv <file> <key_name>

# replace the value of a certain key
./yqyml_gen.sh -vr <file> <key_name> <value>
```

### General stuff
Repo to demo yq usage as a template engine:
- in `yq` expressions are made up of operators and pipes
- yq mode is `eval`, which allows reading, searching, and editing YAML files
- `yq` parses YAML files in the similar way to tree parsing, dividing the YAML files into different node types, which are nested in one another.

* Install `yq`:
```bash
# export BINARY=yq_linux_amd64
# export VERSION=v4.30.5
wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY}.tar.gz -O - |\
tar xz && mv ${BINARY} /usr/bin/yq

# Apple MAC chip 
# export BINARY=yq_darwin_arm64
# follow redirects with L daaam
curl -L https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY}.tar.gz --output yq.tgz
tar -xvzf yq.tgz
```

* Evaluate a YAML file:

    * VERSION=v4.16.2 does not eval by default: try `./yq_version/yq_linux_amd64 personal_data.yml`
```bash
# output the content of personal_data.yaml
yq personal_data.yaml

# needs to be done explicitly for v4.16.2
yq eval personal_data.yaml 
```

* access data from YAML files:
```bash
# access a field
yq '.name' personal_data.yaml

# access nested/indented data
yq '.street_address[]' personal_data.yml

# get the keys of an value with a map
yq '.bundleConfig | keys' ex-config.yaml
```

* change properties of YAML files:
```bash
# change a field
yq '.name = "John Doe"' personal_data.yml
yq '.street_address.number = 256' personal_data.yml
```
### Operators

* to_entries operator:

```bash
# extract the keys of a YAML file
yq 'to_entries | .[] | .key' personal_data.yaml

# extract the values of a YAML file
yq 'to_entries | .[] | .value' personal_data.yaml

# expand anchors and aliases
yq 'explode(.)'  < hobbit.yaml
```

### Similar tooling

* [CUE](https://cuelang.org/docs/about/) - open-source data validation language and inference engine
* [jq](https://stedolan.github.io/jq/tutorial/) -  `sed` for JSON, you can use it to slice and filter and map and transform structured data
* [templating_YAML](https://learnk8s.io/templating-yaml-with-code)