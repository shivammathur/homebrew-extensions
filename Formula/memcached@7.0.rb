# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "070a2882ae113bd96d585f0a9641cc1b4c48aea8bbfcdbd4f4e67f743706cd63"
    sha256 cellar: :any,                 arm64_sonoma:  "173cbb368cda19c039285d7715478a4cbe2c6445b8395e1f8ea704c8c48ed2d0"
    sha256 cellar: :any,                 arm64_ventura: "7468dc114d651de2acbfc3f7c2fe8f0027081f4a522902a668c0aac1a4b886ca"
    sha256 cellar: :any,                 ventura:       "50ae0ae6c92bac147dfe78d4e9fb126b4a486285ba171928c799b5bba76f0f7b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a127fca87ca3f9ace96c313a4c593f51a3001b0d98e564b49643a0c01f3b2024"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b677f8579622c22e50594c249dbf2a1179808d908fb6f09cb22dd18cf491ec1f"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.0"
  depends_on "shivammathur/extensions/msgpack@7.0"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.0"].opt_include}/**/*.h"]
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
