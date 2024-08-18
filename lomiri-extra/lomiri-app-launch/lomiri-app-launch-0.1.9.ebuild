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

DESCRIPTION="User space daemon for launching applications."
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    dev-libs/glib
    dev-libs/gobject-introspection
    dev-util/click
    gnome-extra/zeitgeist
    lomiri-base/lomiri-api
    media-fonts/libertine
    mir-base/mir
    net-misc/curl
    sys-apps/dbus
    sys-apps/systemd
"
RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-build/cmake-extras
    dev-libs/json-glib
    dev-libs/properties-cpp
    dev-util/lttng-ust
"

PATCHES=(
	"${FILESDIR}"/0001-liblomiri-app-launch-jobs-posix.cpp-pass-more-enviro.patch
    "${FILESDIR}"/0002-force-build-launcher-static-as-static.patch
)

src_configure() {
    local mycmakeargs=(
        -DENABLE_TESTS="OFF"
        -DENABLE_COVERAGE="OFF"
        -DUSE_SYSTEMD="ON"
        -DENABLE_MIRCLIENT="OFF"
        -DLOMIRI_APP_LAUNCH_ARCH="None"
    )

    cmake_src_configure
}
