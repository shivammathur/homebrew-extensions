# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT85 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.23.tgz"
  sha256 "67ee7464ccad2335c3fa4aeb0b8edbcf6d8344feea7922620c6a13015d604482"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
  end

  def install
    Dir.chdir "apcu-#{version}"
    inreplace "config.m4",
      "PHP_NEW_EXTENSION(apcu, $apc_sources, $ext_shared,, \\\\$(APCU_CFLAGS))",
      "PHP_NEW_EXTENSION([apcu], [$apc_sources], [$ext_shared],, [$APCU_CFLAGS])"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
