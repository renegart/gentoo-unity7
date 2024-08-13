# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

UVER=
UREV=

inherit ubuntu-versionator

DESCRIPTION="Lomiri (Unity8) Desktop - merge this to pull in all Lomiri packages"
HOMEPAGE="https://lomiri.com"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="+accessibility +apps chat +core +extra +fonts +games gnome +xdm"
#REQUIRED_USE="gnome? ( extra )"
#RESTRICT="binchecks strip test"

RDEPEND="

"

S="${WORKDIR}"
