# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

#Note: this is like a tree, with dependencies-of-dependencies
#You need to update all of these recursively every version bump.
#But at least they are distfiles if github goes down. ¯\_(ツ)_/¯
POLYSEED_DIST_COMIT="e38516561c647522e2e2608f13eabdeab61d9a5d"
SINGLEAPPLICATION_DIST_COMIT="3e8e85d1a487e433751711a8a090659684d42e3b"
MONERO_DIST_COMIT="b45c66e9c62d7e8f24abbcb447f408e618bfd450"
	MINIUPNP_DIST_COMIT="544e6fcc73c5ad9af48a8985c94f0f1d742ef2e0"
	RANDOMX_DIST_COMIT="261d58c77fc5547c0aa7fdfeb58421ba7e0e6e1c"
	RAPIDJSON_DIST_COMIT="129d19ba7f496df5e33658527a7158c79b99c21c"
	SUPERCOP_DIST_COMIT="633500ad8c8759995049ccd022107d1fa8a1bbc9"
	TREZORCOMMON_DIST_COMIT="bff7fdfe436c727982cc553bdfb29a9021b423b0"

DESCRIPTION="A free, open-source Monero wallet"
HOMEPAGE="https://featherwallet.org"
SRC_URI="https://github.com/feather-wallet/feather/archive/refs/tags/${PVR}.tar.gz -> \
${P}.tar.gz
	https://github.com/tevador/polyseed/archive/${POLYSEED_DIST_COMIT}.tar.gz -> \
${P}-polyseed.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${SINGLEAPPLICATION_DIST_COMIT}.tar.gz -> \
${P}-singleapplication.tar.gz
	https://github.com/feather-wallet/monero/archive/${MONERO_DIST_COMIT}.tar.gz -> \
${P}-monero.tar.gz
	https://github.com/miniupnp/miniupnp/archive/${MINIUPNP_DIST_COMIT}.tar.gz -> \
${P}-monero-miniupnp.tar.gz
	https://github.com/tevador/RandomX/archive/${RANDOMX_DIST_COMIT}.tar.gz -> \
${P}-monero-randomx.tar.gz
	https://github.com/Tencent/rapidjson/archive/${RAPIDJSON_DIST_COMIT}.tar.gz -> \
${P}-monero-rapidjson.tar.gz
	https://github.com/monero-project/supercop/archive/${SUPERCOP_DIST_COMIT}.tar.gz -> \
${P}-monero-supercop.tar.gz
	https://github.com/trezor/trezor-common/archive/${TREZORCOMMON_DIST_COMIT}.tar.gz -> \
${P}-monero-trezorcommon.tar.gz
"

# Feather is released under the terms of the BSD license, but it vendors
# code from Monero and Tor too.
LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qrcode xmrig"

DEPEND="
	dev-libs/boost:=[nls]
	dev-libs/libgcrypt:=
	dev-libs/libsodium:=
	dev-libs/libzip:=
	dev-libs/openssl:=
	>=dev-qt/qtcore-5.15:5
	>=dev-qt/qtgui-5.15:5
	>=dev-qt/qtmultimedia-5.15:5[widgets]
	>=dev-qt/qtnetwork-5.15:5
	>=dev-qt/qtsvg-5.15:5
	>=dev-qt/qtwebsockets-5.15:5
	>=dev-qt/qtwidgets-5.15:5
	>=dev-qt/qtconcurrent-5.15:5
	>=dev-qt/qtxml-5.15:5
	media-gfx/qrencode:=
	net-dns/unbound:=[threads]
	net-libs/czmq:=
	media-gfx/zbar:=[v4l]
"
RDEPEND="
	${DEPEND}
	net-vpn/tor
	xmrig? ( net-misc/xmrig )
"
BDEPEND="virtual/pkgconfig"

src_unpack() {
	unpack ${P}.tar.gz \
		${P}-polyseed.tar.gz \
		${P}-singleapplication.tar.gz \
		${P}-monero.tar.gz \
		${P}-monero-miniupnp.tar.gz \
		${P}-monero-randomx.tar.gz \
		${P}-monero-rapidjson.tar.gz \
		${P}-monero-supercop.tar.gz \
		${P}-monero-trezorcommon.tar.gz
	mv -T "${WORKDIR}"/polyseed-${POLYSEED_DIST_COMIT} \
		"${WORKDIR}"/${P}/src/third-party/polyseed || die
	mv -T "${WORKDIR}"/SingleApplication-${SINGLEAPPLICATION_DIST_COMIT} \
		"${WORKDIR}"/${P}/src/third-party/singleapplication || die
	mv -T "${WORKDIR}"/monero-${MONERO_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero || die
	mv -T "${WORKDIR}"/miniupnp-${MINIUPNP_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero/external/miniupnp || die
	mv -T "${WORKDIR}"/RandomX-${RANDOMX_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero/external/randomx || die
	mv -T "${WORKDIR}"/rapidjson-${RAPIDJSON_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero/external/rapidjson || die
	mv -T "${WORKDIR}"/supercop-${SUPERCOP_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero/external/supercop || die
	mv -T "${WORKDIR}"/trezor-common-${TREZORCOMMON_DIST_COMIT} \
		"${WORKDIR}"/${P}/monero/external/trezor-common || die
}

src_prepare() {
	default
	echo "#define FEATHER_VERSION \"${PV}\"" > "${WORKDIR}"/${PF}/src/config-feather.h || die
	echo "#define TOR_VERSION \"NOT_EMBEDDED\"" >> "${WORKDIR}"/${PF}/src/config-feather.h || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DARCH=x86-64
		-DBUILD_64=ON
		-DBUILD_TAG="linux-x64"
		-DDONATE_BEG=OFF
		-DMANUAL_SUBMODULES=1
		-DSTATIC=OFF
		-DSELF_CONTAINED=OFF
		-DUSE_DEVICE_TREZOR=OFF
		-DXMRIG=$(usex xmrig)
		-DWITH_SCANNER=$(usex qrcode)
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON #disables fetching/checking git submodules
		-DVERSION_IS_RELEASE=true
	)

	cmake_src_configure
}

src_compile() {
	cmake_build feather
}

src_install() {
	dobin "${BUILD_DIR}/bin/feather"

	doicon "${WORKDIR}"/${PF}/src/assets/images/feather.png
	domenu "${WORKDIR}"/${PF}/src/assets/feather.desktop
}

pkg_postinst() {
	xdg_pkg_postinst

	einfo "Ensure that Tor is running with 'rc-service tor start' before"
	einfo "using Feather."
}
