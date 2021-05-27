# GitHub Setup

![Shellcheck](https://github.com/ba-st/GitHub-setup/workflows/Shellcheck/badge.svg?branch=master)

This is a tiny script easing the setup of Pharo projects in GitHub.

- [Report a defect](https://github.com/ba-st/GitHub-setup/issues/new?labels=Type%3A+Defect)
- [Request feature](https://github.com/ba-st/GitHub-setup/issues/new?labels=Type%3A+Feature)

It will create a base project structure for a [Pharo](https://pharo.org) project following the [ba-st](https://github.com/ba-st) conventions.

## License

The code is licensed under [MIT](LICENSE).

## Quick Start

### Pre-Requisites

- Create your project in GitHub.
- Configure CI
  - If you want to use GitHub Actions no further configuration is needed.
  - If you want to use Travis CI:
    - Login to [Travis CI](https://travis-ci.com) and enable the integration against your new repo
    - [Install the travis CLI](https://github.com/travis-ci/travis.rb#installation) because you will need it to setup the releases key
- Configure Coverage
  - If you want to use CodeCov login to [CodeCov](https://codecov.io/gh), enable the GitHub integration and create a new secret in your repo (`CODECOV_TOKEN`) with the provided token.
  - If you want to use Coveralls login to [Coveralls](https://coveralls.io) and enable the integration against your new repo
- If you want to use the automatic e-mail notification on releases follow the instructions [here](https://github.com/ba-st-actions/email-release-notification).

### Usage

- Clone this repository
- Execute `setup.sh` providing the [required information](.usage.sh)
- Choose the name of your default branch. We use `release-candidate`, if you want a different one adapt the next steps as needed and use `-d` option
- Review the proposed files and adapt it to your own needs
- Clone your new repository
- Create a new branch called `release-candidate` : `git checkout -b release-candidate`
- If you're using Travis CI you can ease the releases configuration by using `travis setup releases --com` on your repo and copying the encrypted key to the proposed travis yml file
- Move the proposed file structure into your repo (keep an eye on the hidden files)
- Commit and push the changes to GitHub
- Go to the repo settings, set as default branch and protect the `release-candidate` branch

## Proposed Project Structure

The script will propose the following structure:

- `assets/` : Static resources
- `assets/logos/` : Project logo images
- `docs/` : Documentation
- `source/` : Source Code
- `README.md` : Readme
- `CONTRIBUTING.md` : Contribution Guidelines
- `LICENSE` : MIT License
- `docs/Installation.md` : Extended installation instructions

## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)
