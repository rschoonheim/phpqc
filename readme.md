# PHP Quality Container

[![Release](https://github.com/rschoonheim/phpqc/actions/workflows/docker-image.yml/badge.svg)](https://github.com/rschoonheim/phpqc/actions/workflows/docker-image.yml)

Quality container is a docker image that contains a set of tools to help you improve the quality of your PHP project.
It is easy to configure making it easy to integrate into your project.

It comes with the following tools:
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

### Adding extensions to the image
Sometimes you want to add additional extensions to the image. You can do this by creating a new Dockerfile
and extending this image.

**Example**
```dockerfile
FROM ghcr.io/rschoonheim/phpqc:release

# Install additional extensions


# Install additional tools

```

## Using phpqc with CircleCI
The following example shows how to use phpqc in CircleCI. It will run
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
      - run: "phpqc git:commit --message='Apply code style fixes' --push=true"

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
| Command      | Description        |
|--------------|--------------------|
| `git:commit` | Commit all changes |
| `git:push`   | Push all changes   |

### Bitbucket
| Command  | Description                                 |
|----------|---------------------------------------------|
| `bitbucket:pull-request:create` | Create pull request at bitbucket            |






