This addon records your path from the time you invoke the "start recording" command, to the time you invoke the "stop recording" command.


# INSTALLATION
1) Add this folder to your addons folder.
2) Update the `addon_path` variable on line 13 to reflect the path to your windower install


# USAGE
* Invoke the `//pr start` command to start recording, and `//pr stop` to stop recording. Invoke `//pr save your_path_name` to save the path, and then `//pr play your_path_name` to replay your path or `//pr play_reverse your_path_name` to replay your path in reverse.

# KNOWN BUGS:
* This should write a header to each file that indicates the zone name, and then the starting and ending <pos> of the path.
* Incorrect number of args warning when saving

# TODO
* Handle the case where our path zones us
* Find a way to "continue" after path executes. (like, autorun)
* Currently, to start the path, this will try to run directly to the beginning of the path. If there are obstacles in the way, the addon can get stuck. Address this
* Add way to interrupt ongoing path. Add protection to not start a second path while a first is running (probably can use the same flag for both)
* Functionality to list saved paths
* stop playing when player takes over