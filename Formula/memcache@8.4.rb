# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT84 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "main"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bed7594bc74e1655bb76dad3d60feb63d018bcda1a66b3c781b6542f3f5812f9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9d2c0ea53782b5a97e6902a36175ae83c9eb0fc80b9e2d138e743ddaab29f9f8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9d30c99bf2148eda9571a146b9656213a4241835c5bba54deba275b90de2a65d"
    sha256 cellar: :any_skip_relocation, ventura:        "66c9d9c6be25de2b8ddbd0a1749cef8a8c9e643e3e9b33c3374d437adcb12136"
    sha256 cellar: :any_skip_relocation, monterey:       "ba1a65c8fab034342f710d84feb94cf4c07112fbbee1ac002518f75778dc8093"
    sha256 cellar: :any_skip_relocation, big_sur:        "ad81b9f5a2bd2869144df1f0a55540367e471bf6fd7a9f28d6f1a451587ec7bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c9847db803f82c6197e0e626049a25d53bda78de4790a0504f4bd807ce089538"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-memcache
      --with-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    Dir.chdir "memcache-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
