# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MIN_VERSION=3.8

CMAKE_WARN_UNUSED_CLI=1

LIBRETRO_REPO_NAME="stenzek/duckstation"

inherit libretro-core cmake-utils

DESCRIPTION="libretro implementation of duckstation. (PlayStation)"
HOMEPAGE="https://github.com/stenzek/duckstation"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		# enable libretro core, should turn everything else off automatically
		-DBUILD_LIBRETRO_CORE=ON
		# libretro-super sets this too
		-DCMAKE_BUILD_TYPE=Release
		# force off since cmake-utils turns it on I guess and breaks static libs for the core
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake-utils_src_configure
}

src_install() {
	install -m 755 -d "${D}"/usr/$(get_libdir)/libretro
	install -m 755 -t "${D}"/usr/$(get_libdir)/libretro "${BUILD_DIR}"/${LIBRETRO_CORE_NAME}_libretro.so
}
