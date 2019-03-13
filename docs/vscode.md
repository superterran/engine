# Visual Studio Code

Adds a container that runs vscode-server and exposes it to make this more suitable for the remote development workflow, or so you can use vscode with like Crostini (ChromeOS) without the horrible UI performance.

## Usage

Ensure IDE_ENABLE is truthy in your .env file, this adds the IDE container to the composition. Once up'd, you can simply go to http://localhost:8443 and it should load!

## todo

* would be nice to provide a better URL than localhost:8443
* configure xdebug and intellisense
* ideally would like some performance improvements, laggy on my laptop