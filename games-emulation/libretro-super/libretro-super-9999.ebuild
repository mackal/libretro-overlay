# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION="Pulls in all cores and installs .info files"
HOMEPAGE="https://github.com/libretro/${PN}"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="games-emulation/bnes-libretro
games-emulation/bsnes-libretro
games-emulation/desmume-libretro
games-emulation/dosbox-libretro
games-emulation/fb-alpha-libretro
games-emulation/fceumm-libretro
games-emulation/gambatte-libretro
games-emulation/genesis-plus-gx-libretro
games-emulation/handy-libretro
games-emulation/mednafen-libretro
games-emulation/mupen64plus-libretro
games-emulation/nestopia-libretro
games-emulation/picodrive-libretro
games-emulation/quicknes-libretro
games-emulation/snes9x-libretro
games-emulation/snes9x-next-libretro
games-emulation/stella-libretro
games-emulation/vba-next-libretro
games-emulation/vbam-libretro
games-emulation/yabause-libretro
games-emulation/retroarch"

src_install() {
	local retrodir="$(games_get_libdir)/libretro"
	dodir ${retrodir}
	for i in dist/info/*.info ; do
		install -m0644 "${i}" "${D}${retrodir}"
	done
}
