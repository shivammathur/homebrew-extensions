# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT80 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "de57f09b3ec537b66a1d6a4cf1803e37a669a86b7beffaf8c87b8f93e6dc8092"
    sha256 cellar: :any_skip_relocation, ventura:       "bf5b36f59f897f653a3a1bab62943081eac106f3cf087568e0592b6e940bf360"
    sha256 cellar: :any_skip_relocation, big_sur:       "d531032b02995fa862c4de4b158d0c43832121fc18f07159c2cf9f99d5204aac"
    sha256 cellar: :any_skip_relocation, catalina:      "ec267293da1079d61da26b6054da8b9d2c06f2451861d9c5b7a1d81e266aa267"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "255ef4a72f59a2dbd9c6271b0c7959cbacb11b1455911b6513ce5802c36efd03"
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
