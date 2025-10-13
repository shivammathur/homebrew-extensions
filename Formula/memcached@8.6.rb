# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "b50dd397f436c2911ba22ce0ec1e02268eadf5297f9c2497b034986de1a8369b"
    sha256 cellar: :any,                 arm64_sequoia: "c7b65f6a5f7f6ad48dcc3730f72ed630b616585b049aec901c50ce1f7aa9865a"
    sha256 cellar: :any,                 arm64_sonoma:  "e0c46f5bae2c1389a26c0a28438522c72d1caecf40bd50f4d4c564cbebf28130"
    sha256 cellar: :any,                 sonoma:        "355a31cf52b6177b6a4c2dc0a8a5dffc0e08416a0208a837bb68102fc991e8fa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a3f8358220eae5602aeb4a48cd2550ba01c005b3bf1402fb46fd7a36c577150f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdbbd781a40334a0615ef5bfe0f6a9f6aa40729314414a3ada7b68af575b1dbe"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.6"
  depends_on "shivammathur/extensions/msgpack@8.6"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.6"].opt_include}/**/*.h"]
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
