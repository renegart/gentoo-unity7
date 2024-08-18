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

DESCRIPTION="The Lomiri-indicator-network service is responsible for exporting the system settings menu through dbus."
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="LGPL-3 GPL-3"
SLOT="0"

DEPEND="
    dev-db/sqlite
    dev-libs/json-glib
    dev-util/click
    lomiri-extra/lomiri-app-launch
    sys-apps/systemd
    sys-libs/libapparmor
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
    dev-util/intltool
"

PATCHES=(
	"${FILESDIR}"/0001-disable-tests-and-coverage.patch
    "${FILESDIR}"/0002-disable-cmake-policy-CMP0153-warning.patch

)

src_configure() {

    # disable mir client
    local mycmakeargs=(
        -Denable_mirclient=OFF
    )

    cmake_src_configure
}
