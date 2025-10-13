# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "f3096d409425c1a2bf22e12b83fdaca6bc8171731b7d8e6c83704e7b84c583e4"
    sha256 cellar: :any,                 arm64_sonoma:  "d8c5272353a404b8f00f84713704116d1cfaf92cefea671faef53681cb5bfe0b"
    sha256 cellar: :any,                 arm64_ventura: "2eb79e68a8a7b95d04afa1fe64ff7f771eb70c3b9f874cf349de219fc48c9616"
    sha256 cellar: :any,                 ventura:       "a52bb4ee9c534de880320f3e56cedd522ad94a5cb6dc170bd533d33604c27e96"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "137c768e41eae7815c0b9a6621184651d9904a51c501b95cfd445459d2d29447"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6a03fe559f9ac4cabc9e67bc1296982f22148ae4cb61cb55d9884e77b8c6429e"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.3"
  depends_on "shivammathur/extensions/msgpack@7.3"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.3"].opt_include}/**/*.h"]
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
