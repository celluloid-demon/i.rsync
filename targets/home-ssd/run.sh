#!/bin/bash

# Exit on error
set -e

# The trailing slashes in the source and destination paths are important to
# ensure that the contents of the source directory are synchronized rather than
# the directory itself.

# Declare constants
BACKUP_DIR="$HOME/Backups"

# Declare vars
lockfile="/tmp/rsync-home-ssd.lock"
target="/home-ssd/jonathan/"
destination="${BACKUP_DIR}/home-ssd/jonathan/"

# Main logic
main() {

    # -a or --archive: This option is equivalent to -rlptgoD and ensures that
    # rsync preserves permissions, ownership, timestamps, and recursively copies
    # directories.

    # -v or --verbose: Increases the verbosity of rsync, so it will show you the
    # files as they are copied.

    # By default, rsync includes hidden files, so you don't need any additional
    # options for that.

    # Try to acquire the lock
    if mkdir "$lockfile"; then

        # Lock acquired, perform rsync backup
        mkdir -p "$destination"
        rsync -av "$target" "$destination"
        
        # Release the lock
        rmdir "$lockfile"

    else

        # Unable to acquire the lock, a previous instance is still running
        echo "Previous rsync job is still running, canceling."
        exit 1

    fi

}

main
