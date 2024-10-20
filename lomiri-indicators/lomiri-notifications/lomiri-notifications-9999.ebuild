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

DESCRIPTION="An implementation of the Free Desktop Notification server for Lomiri"
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    lomiri-base/lomiri-api
    dev-qt/qtcore:5
    dev-qt/qtquickcontrols2:5
"

RDEPEND="${DEPEND}"

BDEPEND="
    ${DEPEND}
    dev-build/cmake-extras
    dev-util/intltool
    dev-qt/qtdeclarative:5
"
src_prepare() {

    # disable tests for now
    sed -i 's/enable_testing()/# enable_testing()/' CMakeLists.txt  || die
    sed -i 's/add_subdirectory(test)/# add_subdirectory(test)/' CMakeLists.txt || die

    cmake_src_prepare
}
