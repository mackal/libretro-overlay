# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION="${PN} core"
HOMEPAGE="https://github.com/libretro/${PN}"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

EGIT_SOURCEDIR=${S}
S="${WORKDIR}/${P}/src/libretro"

src_prepare() {
	sed -i \
		-e 's/ -O[23]/ /' \
		-e 's/ -fomit-frame-pointer/ /' \
		-e 's/ -funroll-loops/ /' \
		-e 's/ -ffast-math/ /' \
		Makefile || die "sed failed"
}

src_compile() {
	emake TARGET=${PN//-/_}.so
}

src_install() {
	local retrodir="$(games_get_libdir)/libretro"
	dodir ${retrodir}
	install -m0755 "${PN//-/_}.so" "${D}${retrodir}"
}
