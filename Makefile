include .env

init:
	@make build
	@make up
build:
	docker compose build
up:
	docker compose up -d
down:
	docker compose down --remove-orphans
ls:
	docker compose ls
logs:
	docker compose logs
dev-init:
	docker compose exec tellambda terraform -chdir=./environments/dev init
dev-plan:
	docker compose exec tellambda terraform -chdir=./environments/dev plan
dev-apply:
	docker compose exec tellambda terraform -chdir=./environments/dev apply
dev-refresh:
	docker compose exec tellambda terraform -chdir=./environments/dev refresh
dev-destroy:
	docker compose exec tellambda terraform -chdir=./environments/dev destroy
