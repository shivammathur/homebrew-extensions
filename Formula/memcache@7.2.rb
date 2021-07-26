# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT72 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-4.0.5.2.tgz"
  sha256 "7b7667813baea003671f174bbec849e43ff235a8ea4ab7e36c3a0380c2a9ed63"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b47e577a71ec37a02000a5df1fcbeda5cf9bce28633daeff6acbde7d147fd7dc"
    sha256 cellar: :any_skip_relocation, big_sur:       "42e093cdcfb1b52bcb97b9b56c8eeddb7d0851d391c26ec921b2024fc3184e97"
    sha256 cellar: :any_skip_relocation, catalina:      "a71ae5bd6aa1211c1cfcdeb69dfb6c7a254735d01660efdb56587e43ba7c89ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da595555c4038d5cdcd80d6a8f4b3cc76019d42662d44181decec1e534902c23"
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
