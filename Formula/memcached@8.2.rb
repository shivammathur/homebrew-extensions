# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "2893629b87bc021b045bed0cb83e9bc595c1ac38b0f482b313395f530db6e1d2"
    sha256 cellar: :any,                 arm64_sonoma:  "9431a3c0a774ef66b3603fd22ccb6543b795371d36019f34e53d908912643f04"
    sha256 cellar: :any,                 arm64_ventura: "b514fce0e11bb59230fadeebb5b8160f52cd18285c8a0a9ed786aafa197edef6"
    sha256 cellar: :any,                 ventura:       "af05118a4d048cdb6009c8bc61a05a2a7d050855a0c64254c76a89a6f701bbdd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6746d62ca57b4962e002a44597004e229eb0fb9cc8ddca7736e343b66794a694"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f6ede364ec70e8a572f4cec5e34da0532b6b007abbf0da8c1570de3b1d38e906"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.2"].opt_include}/**/*.h"]
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
