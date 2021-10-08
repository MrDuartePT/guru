# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson systemd

COMMIT="c9550e17e6e26802dda23c6070d100aca0cc2810"

DESCRIPTION="Call audio routing daemon"
HOMEPAGE="https://gitlab.com/mobian1/callaudiod"
SRC_URI="https://gitlab.com/mobian1/callaudiod/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~arm64"

LICENSE="GPL-3"
SLOT="0"

S="${WORKDIR}/${PN}-${COMMIT}"

RDEPEND="
	dev-libs/glib
	dev-util/gdbus-codegen
	media-libs/alsa-lib
	|| (
		media-sound/pulseaudio
		>=media-sound/apulse-0.1.12-r4[sdk]
	)
"

BUILD_DIR="${S}"/build
