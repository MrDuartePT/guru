# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	aes-0.7.5
	aho-corasick-0.7.19
	alloc-no-stdlib-2.0.4
	alloc-stdlib-0.2.2
	android_system_properties-0.1.5
	anyhow-1.0.66
	async-compression-0.3.15
	atty-0.2.14
	autocfg-1.1.0
	base64-0.13.0
	base64ct-1.5.2
	bitflags-1.3.2
	block-buffer-0.10.3
	brotli-3.3.4
	brotli-decompressor-2.3.2
	bstr-0.2.17
	bumpalo-3.11.0
	byteorder-1.4.3
	bytes-1.2.1
	bzip2-0.4.3
	bzip2-sys-0.1.11+1.0.8
	cc-1.0.73
	cfg-if-1.0.0
	chrono-0.4.23
	cipher-0.3.0
	clap-3.2.23
	clap_complete-3.2.5
	clap_derive-3.2.18
	clap_lex-0.2.4
	codespan-reporting-0.11.1
	colored-2.0.0
	constant_time_eq-0.1.5
	core-foundation-0.9.3
	core-foundation-sys-0.8.3
	cpufeatures-0.2.5
	crc32fast-1.3.2
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.11
	crossbeam-utils-0.8.12
	crypto-common-0.1.6
	csv-1.1.6
	csv-core-0.1.10
	ctor-0.1.23
	cxx-1.0.78
	cxx-build-1.0.78
	cxxbridge-flags-1.0.78
	cxxbridge-macro-1.0.78
	diff-0.1.13
	digest-0.10.5
	dirs-4.0.0
	dirs-sys-0.3.7
	duct-0.13.5
	either-1.8.0
	embed-resource-1.7.4
	encoding_rs-0.8.31
	encoding_rs_io-0.1.7
	env_logger-0.9.3
	fastrand-1.8.0
	filetime-0.2.17
	flate2-1.0.24
	fnv-1.0.7
	form_urlencoded-1.1.0
	futures-channel-0.3.24
	futures-core-0.3.24
	futures-io-0.3.24
	futures-sink-0.3.24
	futures-task-0.3.24
	futures-util-0.3.24
	generic-array-0.14.6
	getrandom-0.2.7
	h2-0.3.14
	hashbrown-0.12.3
	heck-0.4.0
	hermit-abi-0.1.19
	hmac-0.12.1
	http-0.2.8
	http-body-0.4.5
	httparse-1.8.0
	httpdate-1.0.2
	humantime-2.1.0
	hyper-0.14.20
	hyper-rustls-0.23.0
	iana-time-zone-0.1.51
	iana-time-zone-haiku-0.1.0
	idna-0.3.0
	indexmap-1.9.1
	indoc-1.0.7
	instant-0.1.12
	ipnet-2.5.0
	itoa-0.4.8
	itoa-1.0.4
	jobserver-0.1.25
	js-sys-0.3.60
	junction-0.2.0
	lazy_static-1.4.0
	libc-0.2.135
	link-cplusplus-1.0.7
	log-0.4.17
	lzma-sys-0.1.19
	memchr-2.5.0
	memoffset-0.6.5
	mime-0.3.16
	miniz_oxide-0.5.4
	mio-0.8.4
	ntapi-0.4.0
	num-integer-0.1.45
	num-traits-0.2.15
	num_cpus-1.13.1
	num_threads-0.1.6
	once_cell-1.15.0
	opaque-debug-0.3.0
	openssl-probe-0.1.5
	os_pipe-0.9.2
	os_str_bytes-6.3.0
	output_vt100-0.1.3
	password-hash-0.4.2
	pbkdf2-0.11.0
	percent-encoding-2.2.0
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkg-config-0.3.25
	pretty_assertions-1.3.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.46
	quote-1.0.21
	rand_core-0.6.4
	rayon-1.5.3
	rayon-core-1.9.3
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.6.0
	regex-automata-0.1.10
	regex-syntax-0.6.27
	remove_dir_all-0.5.3
	reqwest-0.11.13
	ring-0.16.20
	rustc_version-0.4.0
	rustls-0.20.6
	rustls-native-certs-0.6.2
	rustls-pemfile-1.0.1
	ryu-1.0.11
	schannel-0.1.20
	scopeguard-1.1.0
	scratch-1.0.2
	sct-0.7.0
	security-framework-2.7.0
	security-framework-sys-2.6.1
	semver-1.0.14
	serde-1.0.147
	serde_derive-1.0.147
	serde_json-1.0.87
	serde_urlencoded-0.7.1
	sha1-0.10.5
	sha2-0.10.6
	shared_child-0.3.5
	slab-0.4.7
	socket2-0.4.7
	spin-0.5.2
	strsim-0.10.0
	subtle-2.4.1
	syn-1.0.102
	sysinfo-0.26.7
	tar-0.4.38
	tempfile-3.3.0
	termcolor-1.1.3
	test-log-0.2.11
	textwrap-0.16.0
	thiserror-1.0.37
	thiserror-impl-1.0.37
	time-0.1.44
	time-0.3.15
	time-macros-0.2.4
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	tokio-1.21.2
	tokio-rustls-0.23.4
	tokio-util-0.7.4
	toml-0.5.8
	tower-service-0.3.2
	tracing-0.1.37
	tracing-core-0.1.30
	try-lock-0.2.3
	typenum-1.15.0
	unicode-bidi-0.3.8
	unicode-ident-1.0.5
	unicode-normalization-0.1.22
	unicode-width-0.1.10
	untrusted-0.7.1
	url-2.3.1
	version_check-0.9.4
	vswhom-0.1.0
	vswhom-sys-0.1.1
	want-0.3.0
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-futures-0.4.33
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	web-sys-0.3.60
	webpki-0.22.0
	webpki-roots-0.22.5
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.36.1
	windows_aarch64_msvc-0.36.1
	windows_i686_gnu-0.36.1
	windows_i686_msvc-0.36.1
	windows_x86_64_gnu-0.36.1
	windows_x86_64_msvc-0.36.1
	winreg-0.10.1
	xattr-0.2.3
	xz2-0.1.7
	yansi-0.5.1
	zip-0.6.3
	zstd-0.11.2+zstd.1.5.2
	zstd-safe-5.0.2+zstd.1.5.2
	zstd-sys-2.0.1+zstd.1.5.2
"

inherit cargo bash-completion-r1 flag-o-matic

DESCRIPTION="Fast and simple Node.js version manager"
HOMEPAGE="https://github.com/Schniz/fnm"
SRC_URI="
	https://github.com/Schniz/fnm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="Apache-2.0 BSD GPL-3 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

PROPERTIES="test_network"
RESTRICT="!test? ( test )"

DEPEND="|| ( >=app-shells/bash-3.0:* app-shells/zsh app-shells/fish )"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/rust
	test? (
		>=app-shells/bash-3.0:*
		app-shells/zsh
		app-shells/fish
	)
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_prepare() {
	# Skip testing against PowerShell and WinCmd
	eapply "${FILESDIR}/${P}-skip-windows-related-tests.patch"

	default
}

src_install() {
	cargo_src_install

	"${D}"/usr/bin/fnm completions --shell bash > fnm.bash-completion || die "Cannot generate bash completions"
	newbashcomp fnm.bash-completion fnm

	"${D}"/usr/bin/fnm completions --shell zsh > fnm.zsh-completion || die "Cannot generate zsh completions"
	insinto /usr/share/zsh/site-functions
	newins fnm.zsh-completion _fnm

	"${D}"/usr/bin/fnm completions --shell fish > fnm.fish-completion || die "Cannot generate fish completions"
	insinto /usr/share/fish/vendor_completions.d/
	newins fnm.fish-completion fnm.fish

	dodoc CHANGELOG.md README.md
}
