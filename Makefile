#!make

ifneq (,$(wildcard ./.env))
    include .env
    export
else
$(error No se encuentra el fichero .env)
endif

help: _header
	${info }
	@echo Opciones:
	@echo ----------------------
	@echo start / stop / restart
	@echo workspace
	@echo stats
	@echo clean
	@echo ----------------------

_urls: _header
	${info }
	@echo -----------------------------------------------------
	@echo [OpenProject] https://openproject.test
	@echo [Traefik] https://traefik.openproject.test/dashboard/
	@echo -----------------------------------------------------

_header:
	@echo -----------
	@echo OpenProject
	@echo -----------

DOCKER_COMPOSE_FILES=-f docker-compose.yml -f docker-compose.traefik.yml

_start-command:
	@docker compose $(DOCKER_COMPOSE_FILES) up -d --remove-orphans

start: _start-command _urls

stop:
	@docker compose $(DOCKER_COMPOSE_FILES) down

restart: stop start

workspace:
	@docker compose $(DOCKER_COMPOSE_FILES) exec web /bin/bash

stats:
	@docker stats

clean:
	@docker compose $(DOCKER_COMPOSE_FILES) down -v --remove-orphans
