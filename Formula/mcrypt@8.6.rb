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
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mcrypt/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "6400c23a8c74559e0e3dc1c27cbf682befd9ea77ecdef9a606dd94a054df9f6a"
    sha256 cellar: :any,                 arm64_sequoia: "09760335c740fc9627b78d91b0e8c0d5cb4109e7abdbc503df71708cac718683"
    sha256 cellar: :any,                 arm64_sonoma:  "ffd6924214b09aff962658f85ea0319e3199ebd46f2bb851d1787524591b5356"
    sha256 cellar: :any,                 sonoma:        "67a79d31fa87d9b4ab4c2b77c9f06ee1cf62e15c0c4d833b6df2da905740dbdc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4f009d86f8e0b6becd6825ee07844366c4a218381919270bcc8e30b69ae5c47a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7e23f0e296150cd8820064897b1c4d22846a7649e5a1c5f1c15369444826c601"
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
        cp "#{Formula["automake"].opt_prefix}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}", fn
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
              "php_stream_filter_alloc(&php_mcrypt_filter_ops, data, persistent, PSFS_SEEKABLE_NEVER)"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
