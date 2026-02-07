# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  env :std
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/06dac62747f0819ebc110fd6ab4a90a0229bd2b6.tar.gz?commit=06dac62747f0819ebc110fd6ab4a90a0229bd2b6"
  version "8.6.0"
  sha256 "8801480c3fc7241f6952dfb5d01c2bc61d2e4a32ca31bb6d539e7b3945459a35"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"
  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
