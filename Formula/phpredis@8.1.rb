# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT81 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.3.0.tgz"
  sha256 "0d5141f634bd1db6c1ddcda053d25ecf2c4fc1c395430d534fd3f8d51dd7f0b5"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2ddf2a3ca66601ec3d21e1f88b7a6ccdaba58dfdaf5db86bc456a53c525aee03"
    sha256 cellar: :any,                 arm64_sequoia: "0e142a0dedb7eef897e114a64071acf572a6a5679f4efd293ef21b8f860e3274"
    sha256 cellar: :any,                 arm64_sonoma:  "b4cdeee418c68bbf9254d5717a24916b8c8a3bce09e74060b14145ec2ac114d2"
    sha256 cellar: :any,                 sonoma:        "b7b7b1efac75fdd07f1846ebb7f8a6368386c0f6331bd8e140db8736de97d1b3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bc918e9306e1e5a739f48b7f557c810ccb8003691d33202ab860f64f6994fdbf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2c8c2f2d9edfaf1fa70b9486c5be6bbc199110f5f316b64cd29211f2b3833f4b"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.1"
  depends_on "shivammathur/extensions/msgpack@8.1"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.1"].opt_include}/**/*.h"]
      (buildpath/"redis-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
  end

  def install
    args = %W[
      --enable-redis
      --enable-redis-igbinary
      --enable-redis-lz4
      --enable-redis-lzf
      --enable-redis-msgpack
      --enable-redis-zstd
      --with-liblz4=#{Formula["lz4"].opt_prefix}
      --with-libzstd=#{Formula["zstd"].opt_prefix}
    ]

    on_macos do
      args << "--with-liblzf=#{Formula["liblzf"].opt_prefix}"
    end

    Dir.chdir "redis-#{version}"
    patch_redis
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
