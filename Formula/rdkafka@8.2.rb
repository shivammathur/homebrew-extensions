# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT82 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.2.tgz"
  sha256 "b250b0b6df32484e59936b676983ba134376d15652f02552b2bf0482ab2cbce9"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "95ea5c88c637628cc42663bfba763e3ed35fc7677b0ef79fd3e5f61ff69164e7"
    sha256 cellar: :any,                 big_sur:       "8c5ece081a0569a0ed04afadba27ccc661397e34bf96b13d3b2f8292c793f39e"
    sha256 cellar: :any,                 catalina:      "a0db6c6ca968cbd91758cdaa4f9c81cc32e0b98d9a04868a8938aa0969f0ad73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c860d68ef7f548ab6dee272583268cb3fa8367625171f73b27d2e558d3504796"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
