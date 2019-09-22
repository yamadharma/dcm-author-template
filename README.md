# Template

## Compilation with Makefile

- run `make` program

``` bash
  make
```

- see `out/default.pdf` 

- clean working directory

```bash
  make clean
```

## Compilation without Makefile

- run LaTeX

```
  lualatex default
```

- run BibTeX

```
  bibtexu bu1.aux
```

- run LaTeX twice

```
  lualatex default
  lualatex default
```

- see `default.pdf`

