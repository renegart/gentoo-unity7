# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake qmake-utils

DESCRIPTION="Backend dispatcher service for various mobile phone related operations"
HOMEPAGE="https://gitlab.com/ubports/development/core/${PN}"

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="
    dev-libs/libphonenumber
    gnome-base/dconf
    lomiri-base/lomiri-api
    lomiri-extra/lomiri-url-dispatcher
    media-sound/pulseaudio
    net-libs/telepathy-qt
    net-im/telepathy-mission-control
    dev-qt/qtcore:5
    dev-qt/qtmultimedia:5
    x11-libs/libnotify
"

RDEPEND="${DEPEND}"

BDEPEND="
	dev-build/cmake-extras
    dev-util/intltool
    dev-build/samurai
    dev-qt/qtdeclarative:5
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/0001-CMakeLists.txt-pkgconf-module-name-changed-history-s.patch
)

src_configure() {

    # add 'qmake' to PATH
    export PATH="$(qt5_get_bindir):${PATH}"

    # disable tests for now
    local mycmakeargs=(
        -DSKIP_QML_TESTS=ON
    )

    cmake_src_configure
}
