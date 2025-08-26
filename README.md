# Author's template for [Discrete and Continuous Models and Applied Computational Science](http://journals.rudn.ru/miph)

## Setup with docker:

- Install `docker`
- Clone this repo & cd into it
- Build the image (**might take several hours!**) `docker build . -t texlive`
- Run the container: `docker run -it --name texlive_container texlive /bin/bash`
- Inside the container:
	- Git-clone this repo & cd into its `template` folder
	- Run `make` (you may have to run it twice due to some font caching issues)

## Workflow with docker:
- _Optional: install the [vscode remote extension](https://code.visualstudio.com/docs/remote/remote-overview) and connect to your docker container via it_
- Perform your TEX-work in the container ...
- After you're done, don't exit the container right away if you want to save your work in the container. Instead you should open a new terminal window (on your local machine, not the container) and make docker-commit so you don't lose any progress: `docker commit texlive_container texlive:{new container's tag goes here, for example: v1.0}`. Later, you might restore your progress by running the container from the new image: `docker run -it --name texlive_container texlive:v1.0 /bin/bash`
- Repeat the `run` / `commit` cycle as many times as you need
