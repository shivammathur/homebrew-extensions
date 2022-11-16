# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "6e9c9bad61f5808f938b00ea599fecce7c23756d175db549fd763f2412b91bb8"
    sha256 cellar: :any,                 arm64_big_sur:  "263ad5a1f0528cb78d7dfcd23d4fe5f3ac9fe44011d12ee437940c5979b3c6a8"
    sha256 cellar: :any,                 monterey:       "a7ea0f984b68a2a0af69ce3f549bb1064c3ddd79b08c4ef5bced72bcb322fca2"
    sha256 cellar: :any,                 big_sur:        "f66ca42dc85c08064e4e57b5efcf9f6b732f518d4df5082eb6701284b4675623"
    sha256 cellar: :any,                 catalina:       "6b3b1f822300e08c2aa8dbfde7b4a0c13059fdb5e67ebaa4709b22a66fde0e0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ae5df0f05803e282c856f1f1e36ae3f745fcbb725e0887713b8953cdc7c1e771"
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
