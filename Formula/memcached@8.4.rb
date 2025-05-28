# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT84 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.3.0.tgz"
  sha256 "2b85bf6699497170801fb4d06eb9c9a06bfc551cdead04101dd75c980be9eebf"
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/memcached/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "56a0612fa2abee05b569b554451cdb8486eff3b00f3b7dd843a6e23e41af50ea"
    sha256 cellar: :any,                 arm64_sonoma:  "c3885b13ddccad490c8132c833c588d8b6d0684928a9cac91660a4d8fba7d53d"
    sha256 cellar: :any,                 arm64_ventura: "ddebc1d11272ed15634126ee7a6a8894f3e0264aa3f413b34a7c29f470c5cebe"
    sha256 cellar: :any,                 ventura:       "bde4638080feab1d17db1446838253a5bfaee0e507662710c08e15addbd8fb17"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "633b7ba956c6188737a08a70ae62232945899c12e97be284a019caed7b19559f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ffeddb5680d076290aed2616c2fce29f94cca96f5682963b2f0652e006f0ae6e"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.4"
  depends_on "shivammathur/extensions/msgpack@8.4"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.4"].opt_include}/**/*.h"]
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
