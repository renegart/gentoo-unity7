# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg qmake-utils

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

# gmenuharness
# gtest
# lomiri-url-dispatcher
DEPEND="
    app-crypt/libsecret
    dev-libs/glib
    lomiri-base/lomiri-api
    lomiri-extra/lomiri-url-dispatcher
    net-misc/ofono
    net-misc/libqofono
    net-misc/networkmanager
    dev-qt/qtcore:5
    dev-qt/qtdbus:5
"

RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake-extras
    dev-util/intltool
    dev-qt/qtdeclarative:5
"

src_configure() {

    # add 'qmlplugindump' to PATH
    export PATH="$(qt5_get_bindir):${PATH}"

    # disable tests for now
    local mycmakeargs=(
        -DENABLE_TESTS=OFF
        -DENABLE_COVERAGE=OFF
    )

    cmake_src_configure
}
