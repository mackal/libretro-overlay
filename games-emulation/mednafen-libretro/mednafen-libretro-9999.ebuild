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
IUSE="gba snes psx +wswan +ngp +vb +pce-fast +pcfx +lynx"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e 's/ -O[23]/ /' \
		-e 's/ -fomit-frame-pointer/ /' \
		-e 's/ -funroll-loops/ /' \
		Makefile || die "sed failed"
}

src_compile() {
	for i in gba snes psx wswan ngp vb pce-fast pcfx lynx; do
		if use ${i} ; then
			emake core=${i//-/_} TARGET=mednafen_${i//-/_}_libretro.so
			emake clean #build system weird
		fi
	done
}

src_install() {
	local retrodir="$(games_get_libdir)/libretro"
	dodir ${retrodir}
	for i in mednafen_*_libretro.so ; do
		install -m0755 "${i}" "${D}${retrodir}"
	done
	prepgamesdirs
}
