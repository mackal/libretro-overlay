# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games git-2

DESCRIPTION="bsnes emulation core ported to libretro"
HOMEPAGE="http://gitorious.org/bsnes/bsnes"
SRC_URI=""

EGIT_REPO_URI="git://gitorious.org/bsnes/bsnes.git"
EGIT_BRANCH="libretro"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="profile_accuracy +profile_balanced profile_performance"

REQUIRED_USE="|| ( profile_accuracy profile_balanced profile_performance )"

RDEPEND=""

DEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	for i in profile_accuracy profile_balanced profile_performance ; do
		if use ${i} ; then
			emake \
				ui=target-libretro \
				profile=${i#profile_}
			mv "${WORKDIR}/${P}/out/bsnes_libretro.so" "${WORKDIR}/${P}/out/bsnes_${i#profile_}_libretro.so"
		fi
	done
}

src_install() {
	mkdir -p "${D}/$(games_get_libdir)/libretro"
	for i in profile_accuracy profile_balanced profile_performance ; do
		if use ${i} ; then
			cp "${WORKDIR}/${P}/out/bsnes_${i#profile_}_libretro.so" "${D}/$(games_get_libdir)/libretro"
		fi
	done
}
