# PHP Quality Container

[![Release](https://github.com/rschoonheim/phpqc/actions/workflows/docker-image.yml/badge.svg)](https://github.com/rschoonheim/phpqc/actions/workflows/docker-image.yml)

Quality container is a docker image that contains a set of tools to help you improve the quality of your PHP project. It is easy
to configure making it easy to integrate into your project.

To keep the image small and fast, the image is based on Alpine Linux. And 
has the following tools installed:

* Refactoring
  * Rector
* Testing
  * phpunit
  * phpunit speedtrap
* Static Analysis
  * phpmd
  * phpstan
* Laravel
  * [Laravel Pint](https://laravel.com/docs/9.x/pint)
  * [Larastan](https://github.com/nunomaduro/larastan)
 
## Getting Started
To start using PHP Quality Container, you need to 
pull our pre-built image. You can do this by running the following command:

```bash
$ docker pull ghcr.io/rschoonheim/phpqc:release
```

### CircleCI
The following example shows how to use PHP Quality Container in CircleCI. It will run
rector to perform refactorings and fix code styling. After each step
it will commit the changes to the repository.

```yaml
version: 2.1

executors:
  phpqc:
    docker:
      - image: ghcr.io/rschoonheim/phpqc:release

jobs:
  rector-php:
    executor: phpqc
    steps:
      - add_ssh_keys:
          fingerprints:
            - "NO:PE:SE:CR:ET:KE:Y"
      - checkout
      - run: "rector"
      - run: "git-commit"
  code-style:
    executor: phpqc
    steps:
      - add_ssh_keys:
          fingerprints:
            - "NO:PE:SE:CR:ET:KE:Y"
      - checkout
      - run: "pint"
      - run: "git-commit"

workflows:
  development:
    jobs:
      - rector-php:
          filters:
            branches:
              ignore: master
      - code-style:
          requires:
            - rector-php
          filters:
            branches:
              ignore: master
```

## Commands Available

### Git
| Command    | Description                             |
|------------|-----------------------------------------|
| `git-push` | Commit & push changes to the repository |






