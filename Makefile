IMAGE_NAME = aoc-2019
VOLUMES = --volume="$(PWD):/var/run/aoc"
RUN_DEFAULTS = docker run --rm -it \
	$(VOLUMES)

all: shell

image:
	docker build -t $(IMAGE_NAME) .

shell: image
	$(RUN_DEFAULTS) $(IMAGE_NAME) bash
