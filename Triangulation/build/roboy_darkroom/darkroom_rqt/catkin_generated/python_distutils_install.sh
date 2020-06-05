#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/src/roboy_darkroom/darkroom_rqt"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/install/lib/python2.7/dist-packages:/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build" \
    "/usr/bin/python2" \
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/src/roboy_darkroom/darkroom_rqt/setup.py" \
    build --build-base "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/roboy_darkroom/darkroom_rqt" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/install" --install-scripts="/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/install/bin"
