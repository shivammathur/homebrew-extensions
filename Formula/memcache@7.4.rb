# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT74 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-4.0.5.2.tgz"
  sha256 "7b7667813baea003671f174bbec849e43ff235a8ea4ab7e36c3a0380c2a9ed63"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2b55a03fbdeba04847b21423086ee636cfd9fd6f83dbd469a8ae653beddc3583"
    sha256 cellar: :any_skip_relocation, big_sur:       "81a021474dd7fa22160051997b8835b941a9ca9593f46592c3aac1bcbf8f5a74"
    sha256 cellar: :any_skip_relocation, catalina:      "d2c52b467943db32aa82a31fa466e60623e47c4eed0ea3866aeca48e8f2953d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2eef635c4c163a0032880461465e66469899d493c7bc3c5d16eb67873e3a6a2"
  end

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
