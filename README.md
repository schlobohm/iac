# schlobohm infrastructure-as-code

## Clone repo

```bash
$ git clone git@github.com:schlobohm/iac
$ cd iac/
```

## Replace placeholder variables as needed

```bash
$ git grep -rl "{{PASSWORD_ROOT}}" . | xargs sed -i 's/\{\{PASSWORD_ROOT\}\}/password123/g'
```

## Copyright and license

&copy; 2022 [Nick Schlobohm](mailto:nks@schlobohm.one). Licensed under the [GNU Affero General Public License, version 3](LICENSE).
