# Xdebug

Xdebug is baked into all the images, with this using docker you have to set port mappings for things to work,
otherwise it's a fairly standard setup. 

## How to start debugging and profiling

https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc?hl=en

## Cachegrind Profiling

These live in ./var/cachegrind

Enable them using the xdebug helper profile setting

Only run them when needed, these can take up a lot of space!

https://kcachegrind.github.io/html/Home.html

## Example Visual Studio Code Debug Configuration

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "port": 9000,
            "pathMappings": { 
                "/sites/dl": "${workspaceRoot}" // the trick is setting the path mappings
            }
        },
        {
            "name": "Launch currently open script",
            "type": "php",
            "request": "launch",
            "program": "${file}",
            "cwd": "${fileDirname}",
            "port": 9000
        }
    ]
}
```