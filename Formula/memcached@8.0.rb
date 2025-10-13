# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "5b7a28a18b672c838c5a56177f799daed61b1c64c032958084acd37c1a296789"
    sha256 cellar: :any,                 arm64_sonoma:  "3195a0c004427710b1ebc3a1d2eef8ad6463e2566d1a995aa2a19b51845520a6"
    sha256 cellar: :any,                 arm64_ventura: "6150ca6237f0a007c6d7e1bb390e2a6e67f6c368c45124eb3eed579afb48363c"
    sha256 cellar: :any,                 ventura:       "c7e5a7ca88763a59385c9219f538675e4a3f187b975f41d2e34fa4f4997ead17"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0f398b299644583c68e00bc4b0defaf0dd6f4751eb2ea8b8e48fb763599f6170"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0ffda6a4c9f064680ac8aa49ad7d5448a5acf6cf039ee4e9fca6d0a0fa7a587"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.0"
  depends_on "shivammathur/extensions/msgpack@8.0"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.0"].opt_include}/**/*.h"]
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
