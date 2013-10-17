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

EGIT_SOURCEDIR=${S}
S="${WORKDIR}/${P}/svn-current/trunk"

src_prepare() {
	sed -i \
		-e 's/ -O[23]/ /' \
		-e 's/ -fomit-frame-pointer/ /' \
		-e 's/ -funroll-loops/ /' \
		-e 's/ -ffast-math/ /' \
		makefile.libretro || die "sed failed"
}

src_compile() {
	emake -f makefile.libretro TARGET=${PN//-/_}.so
}

src_install() {
	mkdir -p "${D}/$(games_get_libdir)/libretro"
	cp "${S}/${PN//-/_}.so" "${D}/$(games_get_libdir)/libretro"
}
