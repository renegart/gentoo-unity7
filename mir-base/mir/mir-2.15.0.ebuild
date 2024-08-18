
# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

KEYWORDS="~amd64"
SRC_URI="https://github.com/MirServer/${PN}/releases/download/v${PV}/${PN}-${PV}.tar.xz"


DESCRIPTION="Mir Display Server."
HOMEPAGE="https://github.com/MirServer"

LICENSE="GPL-2 LGPL-2"
SLOT="0"

DEPEND="
    sys-apps/util-linux
    dev-libs/glib
    dev-libs/libevdev
    dev-libs/libinput
    dev-libs/nettle
    dev-libs/wayland
    dev-util/lttng-ust
    gui-libs/egl-gbm
    media-libs/freetype
    media-libs/glm
    media-libs/libepoxy
    media-libs/mesa[wayland]
    x11-libs/libXcursor
    x11-libs/libxkbcommon
    x11-misc/xkeyboard-config
"

RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake
    dev-cpp/gflags
    dev-cpp/glog
    dev-cpp/libxmlpp:2.6
    dev-cpp/yaml-cpp
    dev-libs/boost
    dev-python/pillow
"
src_configure() {

    # disable tests for now
    local mycmakeargs=(
        -DMIR_ENABLE_TESTS=OFF
    )

    cmake_src_configure
}
