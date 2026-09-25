# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT86 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.9.tgz"
  sha256 "2a9ef0817d3bf677f6d7baf8e325629a2758974735d8abad6566384788d424a5"
  revision 1
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mcrypt/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "4d123580268966f6cf47246ef5c436d90a8757afcb6b0e5ee804b7e3e21baaff"
    sha256 cellar: :any, arm64_tahoe:       "c10066ff6046fab21afdf937ab916699eb9ec7c52c26280d9ac4ab39de60cd60"
    sha256 cellar: :any, arm64_sequoia:     "a00b812a8630002af71a571d30d806da32aa4cef9886008a13375c67d3c110f7"
    sha256 cellar: :any, arm64_linux:       "9cccd7138724514a2d5e015eab04bd6471f99828ab9eabd8cdbc2b86d745200f"
    sha256 cellar: :any, x86_64_linux:      "db107ea8710b7aaf7b85ca63c9b1cb49adfebb3bb91a9745280e941438e63d7b"
  end

  depends_on "automake" => :build
  depends_on "libtool"

  resource "libmcrypt" do
    url "https://downloads.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz"
    sha256 "e4eb6c074bbab168ac47b947c195ff8cef9d51a211cdd18ca9c9ef34d27a373e"
  end

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    ENV.append "CFLAGS", "-Wno-implicit-int"

    resource("libmcrypt").stage do
      # Workaround for ancient config files not recognising aarch64 macos.
      %w[config.guess config.sub].each do |fn|
        cp "#{Utils::Path.formula_opt_prefix("automake")}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}",
fn
      end

      # Avoid flat_namespace usage on macOS
      inreplace "./configure", "${wl}-flat_namespace ${wl}-undefined ${wl}suppress", "" if OS.mac?

      system "./configure", "--prefix=#{prefix}",
                            "--mandir=#{man}"
      system "make", "install"
    end

    Dir.chdir "mcrypt-#{version}"
    inreplace "mcrypt.c", "ext/standard/php_rand.h", "ext/random/php_random.h"
    inreplace "mcrypt_filter.c" do |s|
      old_filter_create = "static php_stream_filter *php_mcrypt_filter_create(const char *filtername, " \
                          "zval *filterparams, uint8_t persistent)"
      new_filter_create = "static php_stream_filter *php_mcrypt_filter_create(const char *filtername, " \
                          "zval *filterparams, bool persistent)"
      s.sub! "#include \"php.h\"", <<~C
        #include "php.h"
        #ifndef INI_STR
        #define INI_STR(name) zend_ini_string((name), strlen(name), 0)
        #endif
      C
      s.sub! "php_mcrypt_filter,\n", "php_mcrypt_filter,\n    NULL,\n"
      s.gsub! old_filter_create, new_filter_create
      s.gsub! "php_stream_filter_alloc(&php_mcrypt_filter_ops, data, persistent)",
              "php_stream_filter_alloc(&php_mcrypt_filter_ops, data, persistent, " \
              "PSFS_SEEKABLE_NEVER, PSFS_SEEKABLE_NEVER)"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
