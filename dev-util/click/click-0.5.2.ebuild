# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )

inherit autotools distutils-r1 vala

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"
fi

DESCRIPTION="Click is a simplified packaging format."
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="GPL-3"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="test"

DEPEND="
    dev-libs/glib:2
    dev-libs/json-glib
    dev-libs/libgee
    dev-libs/properties-cpp

    $(vala_depend)
"

RDEPEND="
    ${DEPEND}
    dev-libs/gobject-introspection
"

BDEPEND="
	dev-util/intltool
	dev-build/libtool

	${PYTHON_DEPS}
"

src_prepare() {
	#eapply "${FILESDIR}"/click-remove_pythonbuild.patch

    cp ${FILESDIR}/Makefile_without_setuptools.am ${S}/Makefile.am
    default

    # disable tests
    sed -i "/DBUS_TEST_RUNNER_CHECK/d" configure.ac || die


    eautoreconf
    vala_setup
}

src_compile () {
    # fix QA Notice: warning: implicit declaration of function '__fxstat'
    # fix QA Notice: warning: implicit declaration of function '__fxstat64'
    sed -i "s/return __fxstat/return __xstat/g" preload/clickpreload.c
    sed -i "s/return __fxstat64/return __xstat64/g" preload/clickpreload.c

    emake
    distutils-r1_src_compile
}

src_install() {
    emake DESTDIR="${D}" install

    distutils-r1_src_install
}
