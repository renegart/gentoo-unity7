# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake
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
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
    sys-apps/accountsservice
"

BDEPEND="
    dev-build/cmake-extras
    dev-util/intltool
"
