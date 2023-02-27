# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="PIDFile context processor. Supported py2 and py3"
HOMEPAGE="https://github.com/mosquito/python-pidfile"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test" # https://github.com/mosquito/python-pidfile/issues/7

RDEPEND="
	dev-python/psutil[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest

python_test() {
	eunittest tests/
}
