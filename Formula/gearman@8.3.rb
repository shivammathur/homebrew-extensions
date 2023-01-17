# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT83 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "56768e6faef0e428427e3bbccc48301b51a2b39234d8970d36e951f56f3b3903"
    sha256 cellar: :any,                 arm64_big_sur:  "625b34b51435505f9a0d1d8aa0f425d36b9c61ed55d583dc6fa24250ffe38f45"
    sha256 cellar: :any,                 monterey:       "801596b201a22227b8bda2ccb67113ca8bd5901f45c59f9bf8d8a925a9ae7021"
    sha256 cellar: :any,                 big_sur:        "9ca80f4721189b74a0624c890806b1faaec987d6c1bde56ea601c069ce1907ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c2f09646195e399f1bcdf276e516c540c7adfc742eb84faabb1a2cc5c98f25c"
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
