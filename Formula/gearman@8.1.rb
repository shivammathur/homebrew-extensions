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
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/gearman@8.1-2.1.0"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "6e9c9bad61f5808f938b00ea599fecce7c23756d175db549fd763f2412b91bb8"
    sha256 cellar: :any,                 arm64_big_sur:  "263ad5a1f0528cb78d7dfcd23d4fe5f3ac9fe44011d12ee437940c5979b3c6a8"
    sha256 cellar: :any,                 monterey:       "a5a2a171096c8c01a42bddd8efbff3973d42f963901e3a47a7d3a380a8a5a460"
    sha256 cellar: :any,                 big_sur:        "f66ca42dc85c08064e4e57b5efcf9f6b732f518d4df5082eb6701284b4675623"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9535da1d85b3b6562353d7056dceac2f419c2c95dbb97aeab20e1fbf98d4a5fe"
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
