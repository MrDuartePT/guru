# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Like neofetch but faster"
HOMEPAGE="https://github.com/LinusDierheimer/fastfetch"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/LinusDierheimer/fastfetch.git"
else
	SRC_URI="https://github.com/LinusDierheimer/fastfetch/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X chafa gnome imagemagick pci sqlite vulkan wayland xcb xfce xrandr"

# note - qa-vdb will always report errors because fastfetch loads the libs dynamically
RDEPEND="
	sys-libs/zlib
	X? ( x11-libs/libX11 )
	chafa? ( media-gfx/chafa )
	gnome? (
		dev-libs/glib
		gnome-base/dconf
	)
	imagemagick? ( media-gfx/imagemagick:= )
	pci? ( sys-apps/pciutils )
	sqlite? ( dev-db/sqlite:3 )
	vulkan? ( media-libs/vulkan-loader )
	wayland? ( dev-libs/wayland )
	xcb? ( x11-libs/libxcb )
	xfce? ( xfce-base/xfconf )
	xrandr? ( x11-libs/libXrandr )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

REQUIRED_USE="xrandr? ( X )"

src_configure() {
	local mycmakeargs=(
		-DENABLE_RPM=no
		-DENABLE_LIBPCI=$(usex pci)
		-DENABLE_VULKAN=$(usex vulkan)
		-DENABLE_WAYLAND=$(usex wayland)
		-DENABLE_XCB_RANDR=$(usex xcb)
		-DENABLE_XCB=$(usex xcb)
		-DENABLE_XRANDR=$(usex xrandr)
		-DENABLE_X11=$(usex X)
		-DENABLE_GIO=$(usex gnome)
		-DENABLE_DCONF=$(usex gnome)
		-DENABLE_XFCONF=$(usex xfce)
		-DENABLE_IMAGEMAGICK7=$(use imagemagick && has_version '>=media-gfx/imagemagick-7.0.0' && echo yes || echo no)
		-DENABLE_IMAGEMAGICK6=$(use imagemagick && has_version '<media-gfx/imagemagick-7.0.0' && echo yes || echo no)
		-DENABLE_ZLIB=yes
		-DENABLE_CHAFA=$(usex chafa)
		-DENABLE_SQLITE3=$(usex sqlite)
	)

	cmake_src_configure
}
