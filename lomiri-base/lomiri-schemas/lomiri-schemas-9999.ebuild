# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake

if [[ ${PV} == 9999 ]]; then
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/lomiri-schemas.git"
    inherit git-r3
else
    SRC_URI="https://gitlab.com/ubports/development/core/lomiri-schemas/-/archive/${PV}/lomiri-schemas-${PV}.tar.gz"
fi

DESCRIPTION="This package contains the configuration schemas used by Lomiri."
HOMEPAGE="https://gitlab.com/ubports/development/core/lomiri-schemas"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}
    sys-apps/accountsservice
"

BDEPEND="
    dev-build/cmake-extras
    dev-util/intltool
"
