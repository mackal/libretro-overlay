# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION="${PN} core"
HOMEPAGE="https://github.com/libretro/libretro-mame"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/libretro-mame.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

EGIT_SOURCEDIR=${S}

src_prepare() {
	sed -i \
		-e 's/ -O[23]/ /' \
		-e 's/ -fomit-frame-pointer/ /' \
		-e 's/ -funroll-loops/ /' \
		-e 's/^CFLAGS =/CFLAGS +=/' \
		-e '/^CCOMFLAGS += -O/d' \
		Makefile.libretro || die "sed failed"
}

src_compile() {
	emake -f Makefile.libretro TARGET=mame
}

src_install() {
	local retrodir="$(games_get_libdir)/libretro"
	dodir ${retrodir}
	install -m0755 "mame_libretro.so" "${D}${retrodir}"
	prepgamesdirs
}
