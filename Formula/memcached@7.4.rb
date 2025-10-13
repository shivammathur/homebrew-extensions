# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT74 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.4.0.tgz"
  sha256 "c163434eb0da97c8f45c7ad41d979d381f8b81c49402b1b90b063987fb37972e"
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/memcached/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "74e21bb4a9dcf29ea25611b82a6c5be9282cb76f4fde661ba247e6c7e996f347"
    sha256 cellar: :any,                 arm64_sonoma:  "f779f420a8b28cfa923be9d82d4a41ac92a51606dfe9ec962caf2f012deb424a"
    sha256 cellar: :any,                 arm64_ventura: "ac614d36dccb1ebe93ab3df79bbea94dcc677ead47960ae252ab600dcfbc5878"
    sha256 cellar: :any,                 ventura:       "e3e5ee6f511cf555ce744a9fa6fe9f0bbf082f8cd3a5a49506a32fc74b7c6bba"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8ded0250a7eefa696e14c14bbed97a5b42177b71e85507a4fcab27df54cc4f66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1c46b71ed5964dd22a57482a7de3f0606c2b650f22120e23ada83fdb2448952"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.4"
  depends_on "shivammathur/extensions/msgpack@7.4"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.4"].opt_include}/**/*.h"]
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
