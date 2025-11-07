# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT56 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-4.3.0.tgz"
  sha256 "c0f04cec349960a842b60920fb8a433656e2e494eaed6e663397d67102a51ba2"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e207f8a21e9398e721a933920daa8f03a9c11cb098ceba5b2c5d42e15992aa7a"
    sha256 cellar: :any,                 arm64_sequoia: "9eb40f9ea9bf1a7f537cfa155e0b11c932ced0a1986b622c80f98288973f6f34"
    sha256 cellar: :any,                 arm64_sonoma:  "36e2b21dbea13999c223f35186bebfdc66d043d0c610491aafb1fb5cc1ea686e"
    sha256 cellar: :any,                 sonoma:        "f36506adb44d9297722f048b412d00e1df91647de32bcd2a9ca18eb0ac8742eb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "24fd8b98d7f6b3d37e1c2caa2ab00e1dc6f7775dcd2bc8a24969782ce89fbb44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ce27505e9cfd5cba3e2c0a83ef998d17243c69a217047006046d17535873dce"
  end

  depends_on "liblzf"
  depends_on "shivammathur/extensions/igbinary@5.6"

  def patch_redis
    mkdir_p "include/php/ext/igbinary"
    headers = Dir["#{Formula["igbinary@5.6"].opt_include}/**/*.h"]
    (buildpath/"redis-#{version}/include/php/ext/igbinary").install_symlink headers unless headers.empty?
  end

  def install
    args = %w[
      --enable-redis
      --enable-redis-igbinary
      --enable-redis-lzf
    ]

    on_macos do
      args << "--with-liblzf=#{Formula["liblzf"].opt_prefix}"
    end

    Dir.chdir "redis-#{version}"
    patch_redis
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
