# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT83 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.0.tgz"
  sha256 "defe33e6f7831d82b7283b95e14a531070531acbf21278f3f0d7050505cf3395"
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "NON_BLOCKING_IO_php8"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3df5ca5bbcbe2a72a2716cc50c5ed04d4e0ca8e90cf33a11d570469ace4ec7c4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "82f8c05529298f76f0cfba72f90d6d90e8ac11bf6ced667d273dbf3c8d098150"
    sha256 cellar: :any_skip_relocation, ventura:        "c6bb14b95ae6aa6562bff14933e1a9ac87092ef836a5237327e0b7db13896d10"
    sha256 cellar: :any_skip_relocation, monterey:       "3d2ca37ddf6ed8e8582e8b5009f73f9d7a903a50a2503fd3d5555d2f358d074c"
    sha256 cellar: :any_skip_relocation, big_sur:        "ed208f383a4047d904181490c702fa2f35c1e5173526f7fd4ee1b65a6159044a"
    sha256 cellar: :any,                 catalina:       "5569d9376e6d9c6c552e5b7e12af88c7e40b2f1ad77e5a3fe66caf717cd5b9cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4fcfb8cc4e9b9b295b84a201de46b9eaf5741d3aea45e3e6d7a68c672f5854c5"
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
