COMPOSE_DEV  := docker-compose
COMPOSE_TEST := docker-compose -f docker-compose.test.yml
BASH         := run --rm vets-api bash --login
BASH_DEV     := $(COMPOSE_DEV) $(BASH) -c
BASH_TEST    := $(COMPOSE_TEST) $(BASH) -c

.PHONY: default
default: ci

.PHONY: bash
bash:
	@$(COMPOSE_DEV) $(BASH)

.PHONY: benchmark
benchmark: db
	@RAILS_ENV=benchmark $(BASH_TEST) "bundle exec rake test:benchmark"

.PHONY: ci
ci:
	@$(BASH_TEST) "bundle exec rake db:setup db:migrate ci"

.PHONY: console
console:
	@$(BASH_DEV) "bundle exec rails c"

.PHONY: db
db:
	@$(BASH_DEV) "bundle exec rake db:setup db:migrate"

.PHONY: guard
guard: db
	@$(BASH_DEV) "bundle exec guard"

.PHONY: lint
lint: db
	@$(BASH_DEV) "bundle exec rake lint"

.PHONY: profile
profile: db
	@RAILS_ENV=benchmark $(BASH_TEST) "bundle exec rake test:profile"

.PHONY: rebuild
rebuild:
	@$(COMPOSE_DEV) build

.PHONY: security
security: db
	@$(BASH_DEV) "bundle exec rake security"

.PHONY: spec
spec:
	@$(BASH_TEST) "bundle exec rake spec"

.PHONY: up
up: db
	@$(COMPOSE_DEV) up

.PHONY: clean
clean:
	rm -rf data
	$(COMPOSE_TEST) run vets-api rm -r coverage log tmp
	$(COMPOSE_TEST) down
