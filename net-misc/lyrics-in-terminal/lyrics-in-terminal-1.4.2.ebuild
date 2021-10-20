# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Command Line Lyrics fetcher for MPRIS media players"
HOMEPAGE="https://github.com/Jugran/lyrics-in-terminal"
SRC_URI="https://github.com/Jugran/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/dbus-python[${PYTHON_USEDEP}]"
PYTHON_REQ_USE="ncurses"
