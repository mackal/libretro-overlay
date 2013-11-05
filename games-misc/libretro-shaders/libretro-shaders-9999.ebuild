# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION="${PN} core"
HOMEPAGE="https://github.com/libretro/common-shaders"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/common-shaders.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-gfx/nvidia-cg-toolkit"
RDEPEND="${DEPEND}"

src_install() {
	local retrodir="${GAMES_DATADIR}/retroarch/shaders"
	dodir ${retrodir}
	cp -R * "${D}${retrodir}"
	prepgamesdirs
}
