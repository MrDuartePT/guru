# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

COMMIT="753157433c10720fc6d95bd22319223447513abe"
MY_P="${PN}-${COMMIT}"

DESCRIPTION="A userscript that allows you to play \"up next\"/recommended youtube videos"
HOMEPAGE="https://github.com/cvzi/mpv-youtube-upnext"

SRC_URI="https://github.com/cvzi/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_P}"

MPV_PLUGIN_FILES=( youtube-upnext.lua )
