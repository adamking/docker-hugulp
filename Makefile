SITE_NAME = docker-hugo-gulp-starter
PWD ?= $(shell pwd)
PORT = 8080

define docker
	@docker run \
	--rm \
	-it \
	-v $(PWD):/site \
	--name $(SITE_NAME) \
	$(2) \
	$(SITE_NAME) \
	$(1)
endef

create:
	@docker build -t $(SITE_NAME) . && make install

install:
	$(call docker, make docker-install)

build:
	$(call docker, make docker-build)

serve:
	$(call docker, make docker-serve, -p $(PORT):$(PORT))

terminal:
	$(call docker, bash)

kill:
	@docker kill $(SITE_NAME)

docker-install:
	@npm audit fix

docker-build:
	@hugo -w -v &
	@npm run hugulp build

docker-serve: docker-build
	@npm run hugulp watch &
	@npm run http-server public/ -p $(PORT)

reset-git:
	@rm -rf .git
	@git init
	@git add .
	@git commit -m "Initial commit"
