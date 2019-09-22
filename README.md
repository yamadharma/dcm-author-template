# Template

## Compilation with Makefile

- run `make` program
  ```bash
  make
  ```
- see `out/default.pdf` 
- clean working directory
  ```bash
  make clean
  ```

## Compilation without Makefile

- run LaTeX
  ```bash
  lualatex default
  ```
- run BibTeX
  ```bash
  bibtexu bu1.aux
  ```
- run LaTeX twice
  ```bash
  lualatex default
  lualatex default
  ```
- see `default.pdf`

