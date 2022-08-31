# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT82 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.0.tgz"
  sha256 "defe33e6f7831d82b7283b95e14a531070531acbf21278f3f0d7050505cf3395"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7cfaad4814c1f2e0a455561ed8c4c3efb8b5e47ad40faec37b28a026d93f695d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7495a2fbf0d8adf687d77fa4d440fa17e8eaae274f401ebdbb97c48ce1dc6cf5"
    sha256 cellar: :any_skip_relocation, monterey:       "521cae042f63903dce8c1471ee90f9c237c51d73e9cc3707ac431b706f3e370b"
    sha256 cellar: :any_skip_relocation, big_sur:        "bf5d9967020f5c0b4b15e508a009702327593a113857ddf07b58899f745b94d5"
    sha256 cellar: :any,                 catalina:       "047137a86c0cece0ab6ddab3e293ae7950974ce282f66d7e82aa17bde046faf9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b274bbfb42528d3687419248f3293f223a3d68b0a60d7c8f712d268ba43c1519"
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
