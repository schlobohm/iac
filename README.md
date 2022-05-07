# schlobohm infrastructure-as-code

## Clone repo

```bash
$ git clone git@github.com:schlobohm/iac
$ cd iac/
```

## Replace placeholder variables, etc.

Run the `prepare-variables` script to generate a `VARIABLES` file. Edit that file as necessary, and then run the `prepare-variables` script again with the `inject` option. If you need to start again you can do a `git reset`.

```bash
# Generate a VARIABLES file.
$ ./prepare-variables

# Change all occurrences of "change_me" to fit your needs.
$ nvim VARIABLES # etc.

# When ready, run the prepare-variables script again with the option "inject".
$ ./prepare-variables inject

# If you need to start again, do a git reset.
$ git reset --hard HEAD
```

## Copyright and license

&copy; 2022 [Nick Schlobohm](https://schlobohm.one/~nks) &lt;[nks@schlobohm.one](mailto:nks@schlobohm.one)&gt;. Licensed under the [GNU Affero General Public License, version 3](LICENSE).
