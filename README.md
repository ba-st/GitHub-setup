 <h1 align="center">GitHub Setup</h1>
  <p align="center">
    This is a tiny script easing the setup of Pharo projects in GitHub.
    <br>
    <br>
    <a href="https://github.com/ba-st/GitHub-setup/issues/new?labels=Type%3A+Defect">Report a defect</a>
    |
    <a href="https://github.com/ba-st/GitHub-setup/issues/new?labels=Type%3A+Feature">Request feature</a>
  </p>


I will create a base project structure for a Pharo project following the [ba-st](https://github.com/ba-st) conventions.

## License
- The code is licensed under [MIT](LICENSE).

## Quick Start

### Pre-Requisites
- Create your project in GitHub.
- Login to [Travis CI](https://travis-ci.org) and enable the integration against your new repo
- Login to [Coveralls](https://coveralls.io) and enable the integration against your new repo
- Install the travis CLI because you will need to setup the releases key

### Usage
- Clone this repository
- Execute `setup.sh` providing the required information
- Review the proposed files and adapt it to your own needs
- Clone you new repository
- You can ease the releases configuration in Travis CI by using `travis setup releases` on you repo and copying the encrypted key to the proposed travis yml file
- Move the proposed file structure into your repo
- Commit and push the changes to GitHub
- Go to the repo settings and protect the master branch

## Proposed Project Structure

The script will propose the following structure:
- `assets/` : Location for static resources of the project
- `assets/logos/` : Location of project logo images
- `docs/` : Documentation location
- `source/` : Source Code location
- `README.md` : Readme
- `CONTRIBUTING.md` : Contribution Guidelines
- `LICENSE` : MIT License
- `docs/Installation.md` : Extended installation instructions

## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)
