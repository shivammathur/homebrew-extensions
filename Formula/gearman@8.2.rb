# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT82 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "e90df88d696e89994fc0ffae1ca94f23c858a7851ef4da7cfba2d1f919a18016"
    sha256 cellar: :any,                 arm64_big_sur:  "19bbb1b639092b9b4e2034ab9047b62fe2c65795f527d0a6fefc0c549c2538a7"
    sha256 cellar: :any,                 monterey:       "238267544a5dc5dca98a86d046417407e9b6180aa7132439bdba76fa49bfa7ed"
    sha256 cellar: :any,                 big_sur:        "2401446cdab52cba1981f5b300c771c78d48563ffbc9e743b5101e2a6da938db"
    sha256 cellar: :any,                 catalina:       "352fd2c37de4411f59d7da66134c086a58dc06877a0273a74e667975047e6159"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "61c6eaf512e7b288d6dcc1917135fc94af14ab35ea67b61e59f5929757073928"
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
