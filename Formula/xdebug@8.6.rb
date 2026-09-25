# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/5e99179a40053f85aee20d38d768575455204dcb.tar.gz"
  sha256 "e91ada97daaf58166e275ac23ca1b8211284daf091f7e4cb05352ed2a7033c2d"
  version "3.5.0"
  revision 2
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "72289ec152a03ce4be14db544ab907eaab12472858ffd1c43b733e54cc8dcaec"
    sha256 arm64_tahoe:       "075fb6393a73e0ff9e3cdaee115e600bc749f1b59cb3aba75d5e4a2267c3e64e"
    sha256 arm64_sequoia:     "3b98fdc7a0be3dd1f3a76c7074783f8ced84719199da24e98a9e56a8f0844cc4"
    sha256 arm64_linux:       "461d11db514fcb3e23eb7136f640c4ccd57d82ce3f7a29cf193fe846c8230cb0"
    sha256 x86_64_linux:      "96736c0dd691a6b813b871a7eb344154fcf46f2fce8e87f2a425efc9c5f36d40"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
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
