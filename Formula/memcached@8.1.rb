# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "c67bd4c1d0a9db7525a64b175eb78e20430ed3d95ccf561268d7e8dac900e860"
    sha256 cellar: :any,                 arm64_sonoma:  "98e6af56bc6bfee4ef72a1e2f0a087d6ff1400577fd7ad99c773d87175f217a6"
    sha256 cellar: :any,                 arm64_ventura: "e20d871e56f4f17cb0a2e09249124e7126e0f9812b5b6738f43c23b7314cbed2"
    sha256 cellar: :any,                 ventura:       "435397ad720cefe5f22ae5fb4cb6b745bb509e31221e7a4292a8d0291ef54162"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3dc48eeb10c7f65a99b0ffe8fb7df391fa2c4a4ca12ae59805f716100850e2d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "07e25807cb441eb735a44a077b93619439458536f6ad0b83c407f518b917a5bc"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.1"
  depends_on "shivammathur/extensions/msgpack@8.1"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.1"].opt_include}/**/*.h"]
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
