# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION="${PN} core"
HOMEPAGE="https://github.com/libretro/picodrive"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/picodrive.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

# We don't need to do the config script for this
src_configure() {
	true
}

src_compile() {
	emake -f Makefile.libretro TARGET=${PN//-/_}.so
}

src_install() {
	local retrodir="$(games_get_libdir)/libretro"
	dodir ${retrodir}
	install -m0755 "${PN//-/_}.so" "${D}${retrodir}"
}
