# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT84 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ff1800fc147471c6b3a7b582b971c2582846b6c821fb6004dfae374037bd8d84"
    sha256 cellar: :any,                 arm64_big_sur:  "fa3018e93c2ed8dd56e9d6d7db92e5dff95a63bc3e14d37a63fd6dc7312b8438"
    sha256 cellar: :any,                 ventura:        "1bce27373b1f92563433922a70cf4fbee01ba93604d8b244c0f7799d44bd7eb5"
    sha256 cellar: :any,                 monterey:       "8a98056afd44dfe81547cb5eab72962a35603d4a81e0689e28d382372840cabc"
    sha256 cellar: :any,                 big_sur:        "e2d37052fdcee01da90c61b7061c38b0fd2a05a2e9efe26f01a3cd84aca7365b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a85346da18fe9bc762b28c7f9bf1617081cda47a15f4abd71c714eae5bb671e4"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    inreplace "php_gearman_worker.c", "ZVAL_NEW_ARR", "array_init"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
