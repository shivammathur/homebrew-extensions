# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT56 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-4.3.0.tgz"
  sha256 "c0f04cec349960a842b60920fb8a433656e2e494eaed6e663397d67102a51ba2"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "2defc12a1e080fa39f4944fd1406a3d675bcb7861701f7bc421a697118057bea"
    sha256 cellar: :any,                 arm64_sonoma:   "f727cabf2a1c1e6d43326b39b5ebd9d46c1699bf52bbb0c25963aa91bae62b37"
    sha256 cellar: :any,                 arm64_ventura:  "68d66365ce753879f9e9770fa165198a55f689af8938288623729f37fd10dbf5"
    sha256 cellar: :any,                 arm64_monterey: "4b6d246011629bd0004a5f98522b56f6627ec36cb384145651c599d651a07f3c"
    sha256 cellar: :any,                 sonoma:         "de711ec48a8991d10055a443f12e7e2310808ee84b667a46d4c2989fe2dbb52a"
    sha256 cellar: :any,                 ventura:        "428bd61ebddd2ea434bfa46806436e88f867229e46cdef67744bb6de964b8f55"
    sha256 cellar: :any,                 monterey:       "ffd7b9348e64deedf3687c7d2de92007fcc92cb5097acb0bef05298d74ebe66f"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "cc38ea2cbc1a07b05d5f68090d73f9ce8fab2712a3fb2801772312f723bd1a31"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ec2742cbf1bd43860efa3b6208157d525d0bee4f401eac4e1bb4d273d918e63a"
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
