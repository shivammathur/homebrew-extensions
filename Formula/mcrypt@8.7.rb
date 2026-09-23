# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT87 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.9.tgz"
  sha256 "2a9ef0817d3bf677f6d7baf8e325629a2758974735d8abad6566384788d424a5"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mcrypt/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "10ed67771cc7328139bec88869e826bac6860aea9c0233f2cb84ed9c3da0d363"
    sha256 cellar: :any, arm64_tahoe:       "6077a5be3fa23ef22e9ff557f48ce3d21c69597a98965d006a0280ae67525734"
    sha256 cellar: :any, arm64_sequoia:     "ac0ae03f27148ef466ce15463559d581e96979340d7a2ad9281d3d9b4ade65e3"
    sha256 cellar: :any, arm64_linux:       "5c35139216bf19cca2378481b887b166091e296538928e6c74469fbff92ed13e"
    sha256 cellar: :any, x86_64_linux:      "0f91baa279e1acf997f44797407b3952ea0dda59df128e4b3b6cc60dcce72db7"
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
