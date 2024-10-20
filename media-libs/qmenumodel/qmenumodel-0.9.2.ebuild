# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

KEYWORDS="~amd64"
SRC_URI="https://github.com/AyatanaIndicators/${PN}/archive/${PV}/${PN}-${PV}.tar.gz"

DESCRIPTION="Qt5 renderer for Ayatana Indicators"
HOMEPAGE="https://github.com/AyatanaIndicators/qmenumodel"

LICENSE="LGPL-3"
SLOT="0"

DEPEND="
	dev-libs/glib
"

RDEPEND="${DEPEND}"

BDEPEND="
	dev-build/cmake-extras
    dev-util/intltool
	virtual/pkgconfig
    dev-qt/qtdeclarative:5
"
