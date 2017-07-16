# ------------------------------------------------------------------------------------------------------
# Set up environment variables to be used in other scripts
# ------------------------------------------------------------------------------------------------------
DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/setenv-dev-env-local.sh

cd $DEV_ENV_VAGRANT_DIR

vagrant halt

