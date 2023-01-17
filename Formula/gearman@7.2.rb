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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "345ef4643197202047cdf8f070b7d874e3bd1f151ff02068a6d730283b375d89"
    sha256 cellar: :any,                 arm64_big_sur:  "901d4b9d92d0bef803615beb25390c2557ee0b5e404f345d16e87c37018d3323"
    sha256 cellar: :any,                 monterey:       "8d8c7206098639f9b390626bc992f70924e0ee4dd7874a79d4c05f09c00d3f9e"
    sha256 cellar: :any,                 big_sur:        "518627feb9aae8accd34c5f4f7a6fbef61d14640be7b8d5fff0671122982ceee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "47812f075d2538f8315f2e9ace7e8fcce85bbac5852e2a9deadd29196f17cf67"
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
