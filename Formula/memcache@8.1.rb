# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT81 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.0.tgz"
  sha256 "defe33e6f7831d82b7283b95e14a531070531acbf21278f3f0d7050505cf3395"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4e071e176caa335f0dd72c803dde49f5c1f5a50378ab7956ba91e238728e0364"
    sha256 cellar: :any_skip_relocation, big_sur:       "98ce19000489af2c11d48712625209f58404bcf098c2f2c543d962d6d508653f"
    sha256 cellar: :any_skip_relocation, catalina:      "4fe56ecbea3b0124337d9810dfffb91bb0d6c6b21af0d11f2d6990d9d22d0dae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cf111c9888d2da659604a9f1df745709f9f0778590de3c3d78ac52cef298df69"
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
