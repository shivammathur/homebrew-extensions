# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT72 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "345ef4643197202047cdf8f070b7d874e3bd1f151ff02068a6d730283b375d89"
    sha256 cellar: :any,                 arm64_big_sur:  "901d4b9d92d0bef803615beb25390c2557ee0b5e404f345d16e87c37018d3323"
    sha256 cellar: :any,                 monterey:       "7ece64e60b605d8526a2e8dae430e3c99bf47a10a363196c07a9adddc38327d6"
    sha256 cellar: :any,                 big_sur:        "518627feb9aae8accd34c5f4f7a6fbef61d14640be7b8d5fff0671122982ceee"
    sha256 cellar: :any,                 catalina:       "084a04f57b7aa11571357645e4860ec403e5b8ca2e242fe10df4e8d07f0f39b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "18ca46f91923cc279ea5c3b3257c2a9995b45ff892cc1dc5c68b2d9b97b2dd2c"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
