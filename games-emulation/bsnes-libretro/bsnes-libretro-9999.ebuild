# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games git-2

DESCRIPTION="bsnes emulation core ported to libretro"
HOMEPAGE="http://gitorious.org/bsnes/bsnes"
SRC_URI=""

EGIT_REPO_URI="https://git.gitorious.org/bsnes/bsnes.git"
EGIT_BRANCH="libretro"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="profile_accuracy +profile_balanced profile_performance"

REQUIRED_USE="|| ( profile_accuracy profile_balanced profile_performance )"

RDEPEND=""

DEPEND=""

src_prepare() {
	sed -i \
		-e 's/ -O[23]/ /' \
		-e 's/ -fomit-frame-pointer/ /' \
		-e 's/ -funroll-loops/ /' \
		-e 's/ -ffast-math/ /' \
		Makefile || die "sed failed"
}

src_compile() {
	for i in profile_accuracy profile_balanced profile_performance ; do
		if use ${i} ; then
			emake \
				ui=target-libretro \
				profile=${i#profile_}
			mv "${S}/out/bsnes_libretro.so" "${S}/out/bsnes_${i#profile_}_libretro.so"
			emake clean # need to clean between profiles
		fi
	done
}

src_install() {
	local retrodir="$(games_get_libdir)/libretro"
	dodir ${retrodir}
	for i in out/bsnes_*_libretro.so; do
		install -m0755 "${i}" "${D}/${retrodir}"
	done
}
