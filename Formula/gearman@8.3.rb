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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "683be91c6ac093090cfaafcce0dd2d75ad7af399a788bdec63d43d0396c2b1f8"
    sha256 cellar: :any,                 arm64_big_sur:  "cfda69ea06796b9cfe504f21f96155f86a1c8d98a37a6f56ba375ec1b56b3e17"
    sha256 cellar: :any,                 monterey:       "88e007404b0a57421e63eb8b60597fa00b9f77ad8f6a22818b1980d9b00d209e"
    sha256 cellar: :any,                 big_sur:        "c2d43ac9824e173d5f7820f9d9b9458e46e9e07d3f776594d2633f5da1bbdb8a"
    sha256 cellar: :any,                 catalina:       "44a0712b30b84913faa65e46d977da58525311809d1429a78b9c6675a891b207"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b9a4ea266ba4d5b4af5c51ae0ed2ccbe0fb41a7f08deede729e79eca0e88394"
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
