# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="For the visualisation of molecular and crystal structures."

HOMEPAGE="http://www.xcrysden.org/"

SRC_URI="http://www.xcrysden.org/download/${P}.tar.gz"

LICENSE="GPL-2+"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND=">=dev-lang/tcl-8.6.12
	>=dev-lang/tk-8.6.12
	>=dev-tcltk/togl-2.0-r3
	>=dev-tcltk/bwidget-1.9.14
	>=media-libs/mesa-22.1.3
	>=sci-libs/fftw-3.3.10"

BDEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-ext-bwidget.patch"
	"${FILESDIR}/${P}-gcc_flags.patch"
	"${FILESDIR}/${P}-Togl_lib.patch"
	"${FILESDIR}/${P}-wrapper_paths.patch"
)

src_prepare() {
	default
	cp "${S}/system/Make.sys-shared" "${S}/Make.sys" || die 'Copying Make.sys to build dir failed.'
}

src_compile() {
	emake xcrysden
}

src_install() {
	emake \
		prefix="${D}"/usr \
		install

	domenu "${FILESDIR}/${PN}.desktop"
	doicon -s 32x32 "${FILESDIR}/icons/${PN}.png"
	docompress -x /usr/share/doc/${P}/examples/GAUSSIAN_files/ \
		/usr/share/doc/${P}/examples/Orca_files/ \
		/usr/share/doc/${P}/examples/XSF_Files/ \
		/usr/share/doc/${P}/examples/Scripting/ \
		/usr/share/doc/${P}/examples/FermiSurface \
		/usr/share/man/
}
