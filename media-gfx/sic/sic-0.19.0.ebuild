# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
ab_glyph_rasterizer-0.1.4
adler-1.0.2
adler32-1.2.0
aho-corasick-0.7.18
ansi_term-0.11.0
anyhow-1.0.40
arbitrary-0.4.7
arg_enum_proc_macro-0.3.1
arrayvec-0.5.2
atty-0.2.14
autocfg-1.0.1
avif-serialize-0.6.5
bitflags-1.2.1
bitstream-io-1.0.0
block-buffer-0.7.3
block-padding-0.1.5
bstr-0.2.16
byte-tools-0.3.1
bytemuck-1.5.1
byteorder-1.4.3
cc-1.0.68
cfg-if-1.0.0
chrono-0.4.19
clap-2.33.3
color_quant-1.1.0
conv-0.3.3
crc32fast-1.2.1
crossbeam-channel-0.5.1
crossbeam-deque-0.8.0
crossbeam-epoch-0.9.5
crossbeam-utils-0.8.5
custom_derive-0.1.7
deflate-0.8.6
digest-0.8.1
either-1.6.1
fake-simd-0.1.2
flate2-1.0.20
fnv-1.0.7
generic-array-0.12.4
getrandom-0.1.16
getrandom-0.2.3
gif-0.11.2
globset-0.4.6
globwalk-0.8.1
heck-0.3.3
hermit-abi-0.1.18
ignore-0.4.17
image-0.23.14
imageproc-0.22.0
imgref-1.9.0
interpolate_name-0.2.3
itertools-0.10.0
itertools-0.9.0
jobserver-0.1.22
jpeg-decoder-0.1.22
lazy_static-1.4.0
libc-0.2.95
libfuzzer-sys-0.3.5
linked-hash-map-0.5.4
log-0.4.14
loop9-0.1.3
maplit-1.0.2
matrixmultiply-0.1.15
memchr-2.4.0
memoffset-0.6.4
miniz_oxide-0.3.7
miniz_oxide-0.4.4
nasm-rs-0.2.0
noop_proc_macro-0.3.0
num-0.1.42
num-0.3.1
num-bigint-0.3.2
num-complex-0.3.1
num-derive-0.3.3
num-integer-0.1.44
num-iter-0.1.42
num-rational-0.3.2
num-traits-0.2.14
num_cpus-1.13.0
once_cell-1.7.2
opaque-debug-0.2.3
open-1.7.0
owned_ttf_parser-0.6.0
parameterized-0.3.1
parameterized-macro-0.3.1
paste-1.0.5
pest-2.1.3
pest_derive-2.1.0
pest_generator-2.1.3
pest_meta-2.1.3
png-0.16.8
ppv-lite86-0.2.10
proc-macro2-1.0.27
quote-1.0.9
rand-0.7.3
rand-0.8.3
rand_chacha-0.2.2
rand_chacha-0.3.0
rand_core-0.5.1
rand_core-0.6.2
rand_distr-0.2.2
rand_hc-0.2.0
rand_hc-0.3.0
rav1e-0.4.1
ravif-0.6.4
rawpointer-0.1.0
rayon-1.5.1
rayon-core-1.9.1
regex-1.5.4
regex-syntax-0.6.25
rgb-0.8.27
rulinalg-0.4.2
rust_hawktracer-0.7.0
rust_hawktracer_normal_macro-0.4.1
rust_hawktracer_proc_macro-0.4.1
rustc_version-0.3.3
rusttype-0.9.2
same-file-1.0.6
scoped_threadpool-0.1.9
scopeguard-1.1.0
semver-0.11.0
semver-parser-0.10.2
sha-1-0.8.2
simd_helpers-0.1.0
strsim-0.8.0
strum-0.21.0
strum_macros-0.21.1
syn-1.0.72
textwrap-0.11.0
thiserror-1.0.25
thiserror-impl-1.0.25
thread_local-1.1.3
tiff-0.6.1
time-0.1.43
ttf-parser-0.6.2
typenum-1.13.0
ucd-trie-0.1.3
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.2
v_frame-0.2.1
vec_map-0.8.2
vergen-3.2.0
walkdir-2.3.2
wasi-0.10.2+wasi-snapshot-preview1
wasi-0.9.0+wasi-snapshot-preview1
weezl-0.1.5
which-4.1.0
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
xshell-0.1.14
xshell-macros-0.1.14
zip-0.5.13
"

inherit cargo

S="${WORKDIR}/${P}"
DESCRIPTION="Accessible image processing and conversion from the terminal tool."
HOMEPAGE="https://github.com/foresterre/sic"
SRC_URI="https://www.github.com/foresterre/sic/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"
QA_FLAGS_IGNORED="usr/bin/sic"
DEPEND=">=dev-lang/nasm-2.14.02"
