# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT87 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/5e19866c1766e38c527f9f94faa170370dc4209f.tar.gz"
  sha256 "a11d140cb67da8920df0a063c4d77b893b71b0195bb96f871c5f5915e0544ec8"
  version "3.5.0"
  revision 2
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_golden_gate: "7ada6fcb530f8704420fdb256d8587fbb4665b6525afab5bcbdb3844f950698d"
    sha256 arm64_tahoe:       "57be9aa24db3a8da71ac462ff8667fa3624d0fdc9e69971cbf7a9fe1206b31c2"
    sha256 arm64_sequoia:     "b65d9bc48fbd234914031a03605b240f29829d884b541ff9930518632bf555c3"
    sha256 arm64_linux:       "e89db9c31609a543f598d5ed0192f18fa474695d58ace796fc6b06b8d649f474"
    sha256 x86_64_linux:      "6c30aeb3c781a37e400632c1d4e24d7efc923fb8971137bc2e52e25340a19e71"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "config.m4" do |s|
      s.gsub! "8.7.0", "8.8.0"
      s.gsub! "80700", "80800"
    end
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
