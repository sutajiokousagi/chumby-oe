#!/bin/sh

if [ "x${TOPDIR}" = "x" ]; then
    TOPDIR=${HOME}/chumby-oe
fi

unset MACHINE

if [ "x${BBT_MACHINE}" != "x" ]; then
  MACHINE=${BBT_MACHINE}
fi

if test x"$0" = x"./setup-chumby.sh"; then
    echo "Error: Run via '. ./setup-chumby.sh'"
    exit 1
elif test x"$BASH_SOURCE" = x; then
    echo "Error: you are not running a Bash shell, please use Bash or add support for your shell to the init scripts"
    exit 1
fi


export BBPATH=${TOPDIR}/meta-chumby-private:${TOPDIR}/meta-chumby:${TOPDIR}/openembedded
while [ "x${MACHINE}" = "x" ]
do
    echo "Chose a platform for OE:"
    echo "    1) Falconwing"
    echo "    2) Silvermoon"
    echo "    3) Icecrown"
    echo "    4) Wintergrasp"
    echo -n "-> "
    read -n 1 T
    echo ""

    if [ "x${T}" = "x1" ]
    then
        MACHINE=chumby-falconwing
    elif [ "x${T}" = "x2" ]
    then
        MACHINE=chumby-silvermoon
    elif [ "x${T}" = "x3" ]
    then
        MACHINE=chumby-icecrown
    elif [ "x${T}" = "x4" ]
    then
        MACHINE=chumby-wintergrasp
    fi
done
DISTRO=angstrom-2010.x

BB_ENV_EXTRAWHITE="MACHINE DISTRO TOPDIR"
export MACHINE DISTRO BB_ENV_EXTRAWHITE TOPDIR
export PATH=${TOPDIR}/bitbake-1.12.0/bin:${PATH}
#unalias bitbake 2> /dev/null
#alias bitbake='MACHINE=${MACHINE} bitbake'
echo "Environment set up to build ${DISTRO} for ${MACHINE}"
