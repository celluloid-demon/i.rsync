#!/bin/bash

# Exit on error
set -e

# Declare constants
SETTINGS="./settings"

# Main logic
main() {

    echo "Checking for ${SETTINGS} to back up..."

    # Remove settings file if it exists
	if [ -e "$SETTINGS" ]; then

        echo "${SETTINGS} found, renaming to ${SETTINGS}_BAK..."
        mv "$SETTINGS" "${SETTINGS}_BAK"
        echo "Done."

    else

        echo "(Not found.)"

	fi

}

main
