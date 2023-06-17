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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "836b9375a7480c3ebcf4c0912ac7b5ca802d93831c9f43d6b5f7a0e4b468c8c3"
    sha256 cellar: :any,                 arm64_big_sur:  "cfda69ea06796b9cfe504f21f96155f86a1c8d98a37a6f56ba375ec1b56b3e17"
    sha256 cellar: :any,                 ventura:        "fdb0c46af20c69a82289ce17ec7d1c98d8a0c18770d9ded5a1cdba206a9c91a2"
    sha256 cellar: :any,                 monterey:       "94e2866951dacc374d4893fe3505a07fde7292a2ccf29396ed811356cea53a62"
    sha256 cellar: :any,                 big_sur:        "c2d43ac9824e173d5f7820f9d9b9458e46e9e07d3f776594d2633f5da1bbdb8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0ec9ab46c672bc90bc98e869e48c4df53e8f487852c87aa7aa77d4527c71ffc3"
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
