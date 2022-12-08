# yq_tutorial
Repo to demo yq usage as a template engine:
- in `yq` expressions are made up of operators and pipes
- yq mode is `eval`, which allows reading, searching, and editing YAML files
- `yq`` parses YAML files in the similar way to tree parsing, dividing the YAML files into different node types, which are nested in one another.

* Evaluate a YAML file:
```bash
# output the content of personal_data.yaml
yq personal_data.yaml
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
```
