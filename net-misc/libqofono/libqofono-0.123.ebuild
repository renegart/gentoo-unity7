# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils multibuild

KEYWORDS="~amd64"
SRC_URI="https://github.com/sailfishos/${PN}/archive/refs/tags/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

DESCRIPTION="Library for accessing the ofono daemon, and a Qt declarative plugin for it"
HOMEPAGE="https://github.com/sailfishos/libqofono"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+qt5 qt6"

DEPEND="
    qt5? (
        dev-qt/qtcore:5
    )
    qt6? (
        dev-qt/qtbase:6
    )

"

RDEPEND="${DEPEND}"

BDEPEND="
    dev-build/cmake-extras
    dev-util/intltool
    qt5? (
        dev-qt/qtdeclarative:5
    )
    qt6? (
        dev-qt/qtdeclarative:6
    )
"

pkg_setup() {
	MULTIBUILD_VARIANTS=( $(usev qt5) $(usev qt6) )
}

src_prepare() {
    default

    # disable build of tests
    sed -i 's/test ofonotest//' libqofono.pro || die

    multibuild_copy_sources
}

src_configure() {
    my_src_configure() {

        case ${MULTIBUILD_VARIANT} in
            qt5) eqmake5 ;;
            qt6) eqmake6 ;;
        esac
    }
	multibuild_foreach_variant run_in_build_dir my_src_configure
}

src_compile() {
    multibuild_foreach_variant run_in_build_dir emake
}

src_install() {
    multibuild_foreach_variant run_in_build_dir emake INSTALL_ROOT="${D}" install
}
