# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"
fi

DESCRIPTION="This package contains the configuration schemas used by Lomiri."
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="LGPL-2.1"
SLOT="0.2.0"

DEPEND="
    dev-libs/glib
"

RDEPEND="${DEPEND}"

BDEPEND="
    virtual/pkgconfig
"

src_prepare() {
    # remove hard coded set library installation path
    sed -i "/LIB_INSTALL_PREFIX/d" CMakeLists.txt  || die

    # replace 'LIB_INSTALL_PREFIX' with 'CMAKE_INSTALL_LIBDIR'
    sed -i 's/LIB_INSTALL_PREFIX/CMAKE_INSTALL_LIBDIR/' data/CMakeLists.txt  || die
    sed -i 's/LIB_INSTALL_PREFIX/CMAKE_INSTALL_LIBDIR/' include/lomiri/shell/launcher/CMakeLists.txt || die
    sed -i 's/LIB_INSTALL_PREFIX/CMAKE_INSTALL_LIBDIR/' include/lomiri/shell/application/CMakeLists.txt || die

    cmake_src_prepare
}

src_configure() {

    # disable tests for now
    local mycmakeargs=(
        -DNO_TESTS="YES"
    )
    cmake_src_configure
}
