# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT83 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "f03c2e1d8836393dcfdc8996e2668f82fc8c9b36967b2b9695232b60957f0f8f"
    sha256 cellar: :any,                 arm64_ventura:  "8f33547f3131aa7be010328007c83cbaa316c9595b05e61157d4682ebb005992"
    sha256 cellar: :any,                 arm64_monterey: "cdd7ebc874481173da2966c8420c04679bef417248e891da82482dd03d690e85"
    sha256 cellar: :any,                 arm64_big_sur:  "e08a90206c1bc471725333974d744d46ab890737afe16bf1b3fbb4163bbd46f1"
    sha256 cellar: :any,                 ventura:        "44148f428da772cf7ecdf53fda6df81ecda48598955a415f84aa395ff8ef874c"
    sha256 cellar: :any,                 monterey:       "7a168a8cca70fa6159ddb7cff998cf0dc30dd7c38a5348006d04348d4ae00e51"
    sha256 cellar: :any,                 big_sur:        "32c0c44a4475d46086887b2690f283b8c8a3465a23cc192f5514b61f6a943b75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b92127607994c4f35ad672b3192e9aabd6eca592471d42a812bdc89dc5e93925"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.3"
  depends_on "shivammathur/extensions/msgpack@8.3"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.3"].opt_include}/**/*.h"]
      (buildpath/"memcached-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
  end

  priority "30"

  def install
    args = %W[
      --enable-memcached
      --enable-memcached-igbinary
      --enable-memcached-json
      --enable-memcached-msgpack
      --disable-memcached-sasl
      --enable-memcached-session
      --with-libmemcached-dir=#{Formula["libmemcached"].opt_prefix}
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    Dir.chdir "memcached-#{version}"
    patch_memcached
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
