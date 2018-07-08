# AWS CLI

The [AWS Command Line Interface](https://aws.amazon.com/cli/) (CLI) is a unified tool to manage your AWS services. With just one tool to download and configure, you can control multiple AWS services from the command line and automate them through scripts.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

[binary wrapper package](https://www.habitat.sh/docs/best-practices/#binary-wrapper-packages)

## Usage

```bash
hab pkg install lilian/aws-cli
hab pkg binlink lilian/aws-cli aws   # do not try to binlink all the python deps

aws --version
```
