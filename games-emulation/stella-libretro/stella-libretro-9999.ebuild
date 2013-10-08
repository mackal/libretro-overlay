# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION="${PN} core"
HOMEPAGE="https://github.com/libretro/${PN}"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/${PN}.git"

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
	emake TARGET=${PN//-/_}.so
}

src_install() {
	mkdir -p "${D}/$(games_get_libdir)/libretro"
	cp "${WORKDIR}/${P}/${PN//-/_}.so" "${D}/$(games_get_libdir)/libretro"
}
