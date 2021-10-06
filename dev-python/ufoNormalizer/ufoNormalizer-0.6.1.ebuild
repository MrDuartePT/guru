# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="${PN,,}"
MYP="${MYPN}-${PV}"
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="A tool that will normalize the XML and other data inside of a UFO"
HOMEPAGE="https://github.com/unified-font-object/ufoNormalizer"
SRC_URI="mirror://pypi/${MYPN:0:1}/${MYPN}/${MYP}.zip"
S="${WORKDIR}/${MYP}"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"

BDEPEND="app-arch/unzip"

distutils_enable_tests setup.py
