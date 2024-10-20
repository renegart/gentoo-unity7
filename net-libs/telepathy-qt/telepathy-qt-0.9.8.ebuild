# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

KEYWORDS="~amd64"
SRC_URI="https://github.com/AyatanaIndicators/${PN}/archive/${PV}/${PN}-${PV}.tar.gz"
SRC_URI="https://telepathy.freedesktop.org/releases/${PN}/${PN}-${PV}.tar.gz"

DESCRIPTION="A library for Qt-based Telepathy clients"
HOMEPAGE="https://telepathy.freedesktop.org/wiki/"

LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="
    dev-libs/glib
    media-libs/gstreamer
	net-libs/telepathy-glib
"

RDEPEND="${DEPEND}"

BDEPEND="
	dev-build/cmake-extras
    dev-build/samurai
    dev-util/intltool
    dev-qt/qtcore
    dev-lang/python
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/fix-finding-gio-unix.patch
)

src_configure() {
    local mycmakeargs=(
        # disable build of tests and exapmles for now
        -DENABLE_EXAMPLES=OFF
        -DENABLE_TESTS=OFF
        # disable development warnings
        -Wno-dev
        # disable 'farstream'
        -DENABLE_FARSTREAM=OFF
    )

    cmake_src_configure
}
