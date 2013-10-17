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
IUSE="gba snes psx +wswan +ngp +vb +pce-fast"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e 's/ -O[23]/ /' \
		-e 's/ -fomit-frame-pointer/ /' \
		-e 's/ -funroll-loops/ /' \
		-e 's/ -ffast-math/ /' \
		Makefile || die "sed failed"
}

src_compile() {
	for i in gba snes psx wswan ngp vb pce-fast ; do
		if use ${i} ; then
			emake clean #build system weird
			emake core=${i} TARGET=mednafen_${i//-/_}_libretro.so
		fi
	done
}

src_install() {
	mkdir -p "${D}/$(games_get_libdir)/libretro"
	for i in gba snes psx wswan ngp vb pce-fast ; do
		if use ${i} ; then
			cp "${S}/mednafen_${i//-/_}_libretro.so" "${D}/$(games_get_libdir)/libretro"
		fi
	done
}
