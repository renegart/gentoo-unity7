# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999 ]]; then
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"
fi

DESCRIPTION="This package contains the configuration schemas used by Lomiri."
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="extras test"
RESTRICT="!test? ( test )"

DEPEND="
    extras? (
        dev-libs/glib
    )
"

RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake-extras
    dev-cpp/yaml-cpp
    virtual/pkgconfig

    test? (
        dev-cpp/gtest
    )
"

src_configure() {
    local mycmakeargs=(
        -DDISABLE_TESTS="$(usex !test)"
        -DWITH_EXTRAS="$(usex extras)"
    )
    cmake_src_configure
}
