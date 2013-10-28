# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION="${PN} core"
HOMEPAGE="https://github.com/libretro/Genesis-Plus-GX"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/Genesis-Plus-GX.git"

LICENSE="XMAME"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e 's/ -O[23]/ /' \
		-e 's/ -fomit-frame-pointer/ /' \
		-e 's/ -funroll-loops/ /' \
		-e 's/ -ffast-math/ /' \
		Makefile.libretro || die "sed failed"
}

src_compile() {
	emake -f Makefile.libretro TARGET=${PN//-/_}.so
}

src_install() {
	local retrodir="$(games_get_libdir)/libretro"
	dodir ${retrodir}
	install -m0755 "${PN//-/_}.so" "${D}${retrodir}"
}
