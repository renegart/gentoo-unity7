# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
#DISTUTILS_EXT=1
#DISTUTILS_OPTIONAL=1
#DISTUTILS_SINGLE_IMPL=1
#PYTHON_COMPAT=( python3_{10..13} )

inherit cmake

DESCRIPTION="The Lomiri (Unity8) Desktop"
HOMEPAGE="https://gitlab.com/ubports/development/core/lomiri"

if [[ ${PV} == 9999 ]]; then
    KEYWORDS=""
    EGIT_REPO_URI="https://gitlab.com/ubports/development/core/${PN}.git"
    inherit git-r3
else
    KEYWORDS="~amd64"
    SRC_URI="https://gitlab.com/ubports/development/core/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

COMMON_DEPEND="
	dev-libs/glib
	dev-qt/qtsvg:5
	dev-qt/qtsql:5
	dev-qt/qtxml:5
	gnome-base/gnome-desktop:3
	net-libs/geonames
"

RDEPEND="${COMMON_DEPEND}"

DEPEND="${COMMON_DEPEND}"

BDEPEND="
	dev-build/cmake-extras
    dev-util/intltool
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/0001-cursor-Always-follow-cursor-position-from-mir.patch
	"${FILESDIR}"/0002-Disable-broken-tests-due-to-dropped-mocks-from-mir-2.patch
	"${FILESDIR}"/0005-Disable-lightdm-integration.patch
	"${FILESDIR}"/0006-Change-hard-coded-launcher-logo-to-one-set-by-a-reso.patch
	"${FILESDIR}"/2010_use-desktop-qtmir.patch
)
