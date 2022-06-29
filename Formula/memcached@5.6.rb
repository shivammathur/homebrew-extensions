# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT56 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-2.2.0.tgz"
  sha256 "17b9600f6d4c807f23a3f5c45fcd8775ca2e61d6eda70370af2bef4c6e159f58"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "7e1ec55bd1d01f4407c4d7e3745ba26228217cb7f929ea50fb194f3533ceb77d"
    sha256 cellar: :any,                 arm64_big_sur:  "5c3e66ea06d35d585a8a72690b8df5fffc0e130ac8f7575bab1ce10681f63020"
    sha256 cellar: :any,                 monterey:       "a1a9c9dcb9fe905bd43d62a8573618d38e81d744f4572342da83b99a25c2bd2d"
    sha256 cellar: :any,                 big_sur:        "9c6b2f4a700bca8609bd2c82c6d8db9563108358f9db0a5532e46af6f1856e67"
    sha256 cellar: :any,                 catalina:       "d9f7a42e3e31566aa1daee4604b6c1cb6f6752ca8d7eed16a82631ba094c6bc6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fab3b5542b82091c368ec844123e7351f7d25c3985efb38be47ef804978c30e4"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@5.6"
  depends_on "shivammathur/extensions/msgpack@5.6"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@5.6"].opt_include}/**/*.h"]
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
      --with-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
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
