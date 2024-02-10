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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4a27c32c3bfe58a8adb0eb739c017590a174705c131cf3590d85a955ebcb32df"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a4bdb376f19d507e186de09b1b49baf932f0b56f3215929fcd5ec807253a85d0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c9f7711377fdfe3b150679dd2e59024e38e812ad06aa0672f4577707d5adb9d7"
    sha256 cellar: :any_skip_relocation, ventura:        "e43a50b0d52f39e1182af41167cbb0e2a168f981737634c5416a0f73733278fc"
    sha256 cellar: :any_skip_relocation, monterey:       "b050b3b79dec53ecb278569d823a1ca93aceb2f215a41faabdfa706c858189c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dd1fff87f7d9f96e1175cf4eddc3594058d39d63f5ed0b7adcd6510fd3b4334b"
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
