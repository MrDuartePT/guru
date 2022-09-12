# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Handling event-based streams in Python"
HOMEPAGE="
	https://github.com/Exahilosys/wrapio
	https://pypi.org/project/wrapio/
	"
SRC_URI="https://github.com/Exahilosys/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_sphinx docs
