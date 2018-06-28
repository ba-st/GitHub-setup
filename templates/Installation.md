# Installation

## Basic Installation

You can load **<PROJECT_NAME>** evaluating:
```smalltalk
Metacello new
	baseline: '<BASELINE_NAME>';
	repository: 'github://<OWNER>/<REPO_NAME>:master/repository';
	load.
```
>  Change `master` to some released version if you want a pinned version

## Using as dependency

In order to include **<PROJECT_NAME>** as part of your project, you should reference the package in your product baseline:

```smalltalk
setUpDependencies: spec

	spec
		baseline: '<BASELINE_NAME>'
			with: [ spec
				repository: 'github://<OWNER>/<REPO_NAME>:v{XX}/source';
				loads: #('Deployment') ];
		import: '<BASELINE_NAME>'.
```
> Replace `{XX}` with the version you want to depend on

```smalltalk
baseline: spec

	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec package: 'My-Package' with: [ spec requires: #('<BASELINE_NAME>') ] ]
```
