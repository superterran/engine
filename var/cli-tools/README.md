# CLI Tools

You need tools in these containers, put them here and we will expose them to the appropriate containers 
so you can excute them.

## Installing Tools

You can simply copy them to this directory, we also maintain a few big ones (n98-magerun, artisian, etc)
and can download them using `engine download-cli-tools`, this populates the var/cli-tools/ dir in this repo,
the composition mounts this directory and the images peform a little dance that makes them executable and
places them in the apporpriate path.

## Usage

Once configured, you can connect to a php instance with `engine bash php70` or whatever version is best,
and then you can execute any command i.e. `$ wp-cli` will execute and return help information.