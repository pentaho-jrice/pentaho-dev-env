# ------------------------------------------------------------------------------------------------------
# XXX
# ------------------------------------------------------------------------------------------------------

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/setenv-dev-env-local.sh

cd $DEV_ENV_VAGRANT_DIR

vagrant up

