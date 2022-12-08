# yq_tutorial
Repo to demo yq usage as a template engine


* yq mode is `eval`, which allows reading, searching, and editing YAML files:
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
```

* change properties of YAML files:
```bash
# change a field
yq '.name = "John Doe"' personal_data.yaml
yq '.street_address.number = 256' personal_data.yaml
```