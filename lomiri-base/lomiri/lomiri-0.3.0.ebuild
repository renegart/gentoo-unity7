# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )

inherit ubuntu-versionator

DESCRIPTION="The Lomiri (Unity8) Desktop"
HOMEPAGE="https://gitlab.com/ubports/development/core/lomiri"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

COMMON_DEPEND=""
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"
BDEPEND="
	dev-libs/libevdev
	media-fonts/fonts-ubuntu
"
