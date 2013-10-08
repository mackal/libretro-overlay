# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION="${PN} core"
HOMEPAGE="https://github.com/libretro/fba-libretro"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/fba-libretro.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	cd "${WORKDIR}/${P}/svn-current/trunk"
	emake -f makefile.libretro TARGET=${PN//-/_}.so
}

src_install() {
	mkdir -p "${D}/$(games_get_libdir)/libretro"
	cp "${WORKDIR}/${P}/svn-current/trunk/${PN//-/_}.so" "${D}/$(games_get_libdir)/libretro"
}
