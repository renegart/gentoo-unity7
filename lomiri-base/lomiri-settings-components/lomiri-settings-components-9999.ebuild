# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake qmake-utils

DESCRIPTION="Lomiri settings Components"
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND=""

RDEPEND="${DEPEND}"

BDEPEND="
	dev-build/cmake-extras
    dev-build/samurai
    dev-util/intltool
	virtual/pkgconfig
	dev-qt/qtdeclarative:5
"
src_prepare() {

    # disable tests for now
    sed -i 's/find_package(Qt5Test REQUIRED)/# find_package(Qt5Test REQUIRED)/' CMakeLists.txt  || die
    sed -i 's/add_custom_target(qml_fake_target SOURCES ${QML_EXTRA_FILES})/ # add_custom_target(qml_fake_target SOURCES ${QML_EXTRA_FILES})/' CMakeLists.txt || die
    sed -i 's/enable_testing()/# enable_testing()/' CMakeLists.txt  || die
    sed -i 's/add_subdirectory(tests)/# add_subdirectory(tests)/' CMakeLists.txt || die

    cmake_src_prepare
}

src_configure() {

    # add 'qmlplugindump' to PATH
    export PATH="$(qt5_get_bindir):${PATH}"

    cmake_src_configure
}
