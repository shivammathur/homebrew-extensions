# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "5f342d2292c6a5f1ed815f7bcedb4cfc974230ed4eaae6f587838d020c7a7e8d"
    sha256 cellar: :any,                 arm64_big_sur:  "f148e22d4e17e2d70ed3ded3de94a12c5631f3f566ce5c9d45260fce6035e4e2"
    sha256 cellar: :any,                 monterey:       "b166c72b927bb0ccae7f1fda4c8b38cfb4bb621b03c77f0b2278084a20dad2be"
    sha256 cellar: :any,                 big_sur:        "296fecb056a8bd391b274d9bacc53d9eef53a491da5b7382e6862d4a6e0a2a92"
    sha256 cellar: :any,                 catalina:       "7f3ac320a4067ff883549141af7dfec7ae26840444139af16b98b490ebf55f0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b5e04a38860014ac3b22ea2c46d7a74314ddb31a5b455cceefd99ec8f9e62a5e"
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
