# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT71 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.3.0.tgz"
  sha256 "2b85bf6699497170801fb4d06eb9c9a06bfc551cdead04101dd75c980be9eebf"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/memcached/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b28cbb402eb8a32f9bccea265d200b6ba74d1098f2cade5d56f9b0955c3edbc8"
    sha256 cellar: :any,                 arm64_sonoma:  "891e82268a588c5131e2ed343412a1c66c394fe4d4c946e77339b072994e1f19"
    sha256 cellar: :any,                 arm64_ventura: "67136b181477149c2456d6da555b43ccb6ddb4fbd73ca2ad1b444767cd2f8c6d"
    sha256 cellar: :any,                 ventura:       "c0933957312077470a627bd6c10c96f63a7ab47fac1a3921701a7d9f9d3d368a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4b5e81f369b50e80548f857fcd9f71e47789e291f08f7ecb0f874bed5149ded6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28d2d69d5928041c49db4065385f7eadb459438b4b9ba556dc10ba71877b3cb4"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.1"
  depends_on "shivammathur/extensions/msgpack@7.1"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.1"].opt_include}/**/*.h"]
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
    patch_memcached
    Dir.chdir "memcached-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
