# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "1e547fa2a8582451c0b0c0acfe6f187a059d766dc97ae6c28f5a5ec24984747e"
    sha256 cellar: :any,                 arm64_sequoia: "b9b8af4794cee3877360c483a5b16d40c83638afa70198426929f386955002cc"
    sha256 cellar: :any,                 arm64_sonoma:  "42fa61bb12700e61ff29951c8d3fa18e490802799b8dc37c75263450b1733f79"
    sha256 cellar: :any,                 sonoma:        "733fb95f1eac9da2e5f56cc28caef0e64d4dd3a413762a23a62237c1c92fe871"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5c4bc7b72e3e4764f6efe0a7194ea7c290049e0cd6be76ca7c850021967a049c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cb06daca1e0c27360825d0afa93a8af828372d14df8d73a8144878f1a825a49e"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.5"
  depends_on "shivammathur/extensions/msgpack@8.5"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.5"].opt_include}/**/*.h"]
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
