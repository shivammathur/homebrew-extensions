# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT56 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-3.0.8.tgz"
  sha256 "2cae5b423ffbfd33a259829849f6000d4db018debe3e29ecf3056f06642e8311"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "11d8fedc7fe97c92785b7c1f392e340f0fdd51b85182e43de590caf77289dde7"
    sha256 cellar: :any_skip_relocation, big_sur:       "d7bd1b237c7e262f312ae2437d39a930c913bb42ac0e4878d96f5bb462849988"
    sha256 cellar: :any_skip_relocation, catalina:      "50a2035da542a11457a9d7f00bfd87f55b8adf07d60258f1b6e1507e0ef7a65b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c4fd3bf2910a0d4791bf9711dafa9d774a4a13dbe2dfc13a12b76739c02bcf1"
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
