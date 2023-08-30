# typed: false
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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5f3a96dc92374eea77209aa4b7ed9587655b26013cf2b3389dc41af81c6f55c1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "98cc0b12fff49dc6aef8e9473b989ce475a27295de66e9330989bd0ef4173597"
    sha256 cellar: :any_skip_relocation, ventura:        "bbd1f502b31d80bcc7f0cc5f15246925cd05246fd64af0d6530ae69bb83b5349"
    sha256 cellar: :any_skip_relocation, monterey:       "1fb247bf106a3af882d50a77535da013a0b2479575c729e750dca351e2363af0"
    sha256 cellar: :any_skip_relocation, big_sur:        "def574dad07a1687df3995b04c32f2ade30ecf47a361aed21b7fad295e6eb4d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f032729f099200764eaf6bf6c1054549b8be7e15e0c25c0e7e2df48ada799a9a"
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
