# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils

DESCRIPTION="Lua language server"
HOMEPAGE="https://github.com/sumneko/lua-language-server"
SRC_URI="https://github.com/sumneko/lua-language-server/releases/download/${PV}/${P}-submodules.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
BDPEND="
	${NINJA_DEPEND}
	app-arch/unzip
	dev-util/ninja
	sys-devel/gcc
"
RESTRICT="!test? ( test )"

src_compile() {
	eninja -C 3rd/luamake -f compile/ninja/linux.ninja "$(usex test "test" "luamake")"
	use test && eninja -C 3rd/luamake -f compile/ninja/linux.ninja luamake
	./3rd/luamake/luamake init || die
	# Tests are broken
	eninja -f build/build.ninja all
}

src_install() {
	dobin ./bin/{main.lua,lua-language-server}
	dodoc changelog.md README.md
}
