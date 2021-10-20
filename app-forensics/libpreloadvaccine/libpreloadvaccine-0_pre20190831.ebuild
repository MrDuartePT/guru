# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="634e0155e77bb539a5b35c0ea964bbc525ae3f74"

DESCRIPTION=" Whitelisting LD_PRELOAD libraries using LD_AUDIT"
HOMEPAGE="https://github.com/ForensicITGuy/libpreloadvaccine"
SRC_URI="https://github.com/ForensicITGuy/libpreloadvaccine/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DOCS=( README.md )
PATCHES=( "${FILESDIR}/${PN}-makefile.patch" )
RESTRICT="!test? ( test )"

src_compile() {
	emake build
	use test && emake tests.out
}

src_install() {
	dolib.so libpreloadvaccine.so
	einstalldocs
	echo "😃LD_AUDIT=/usr/$(get_libdir)/libpreloadvaccine.so" > 99libpreloadvaccine || die
	doenvd 99libpreloadvaccine
}
