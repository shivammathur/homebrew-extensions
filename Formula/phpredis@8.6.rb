# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT86 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "11a66b0dc00bce020c7b6d8d66e79a517b0cd08b2a7b4fe03e010fa374047e83"
    sha256 cellar: :any,                 arm64_sequoia: "693f36807cf080bd2b3a4804b3b77de1fb8cd568556e75dfbc42accfaefcd1d5"
    sha256 cellar: :any,                 arm64_sonoma:  "e5101f3545245b9453005eab0c12b883a1125655016f46d0c669c2c6d62568ed"
    sha256 cellar: :any,                 sonoma:        "05ef28ed0354bbb5e845cfebabc3d6e8810d19a0af21ecc56606d8c5a79512cb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1a26cee056e9a4a6a82cf2fbac8fa0c71ab5827687263ba9608e7fa0213b3c42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "83972f758e7372e70909cb8509bf5b2eac88a56ca492e143140f981ec9aedbf4"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.6"
  depends_on "shivammathur/extensions/msgpack@8.6"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.6"].opt_include}/**/*.h"]
      (buildpath/"redis-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
    %w[
      redis_array_impl.c
      redis_array.c
      redis_commands.c
      redis_cluster.c
      cluster_library.c
      library.c
      redis.c
      redis_session.c
    ].each do |f|
      inreplace f, "zval_dtor", "zval_ptr_dtor_nogc"
    end
    %w[
      library.c
      redis_commands.c
      cluster_library.c
    ].each do |f|
      inreplace f, "zval_is_true", "zend_is_true"
    end
    %w[
      redis.c
      redis_cluster.c
    ].each do |f|
      inreplace f, "ZEND_WRONG_PARAM_COUNT()", "zend_wrong_param_count(); RETURN_THROWS();"
    end
    inreplace "redis_cluster.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    inreplace "redis_session.c" do |s|
      s.gsub! "strlen(save_path)", "ZSTR_LEN(save_path)"
      s.gsub! "save_path[", "ZSTR_VAL(save_path)["
      s.gsub! "save_path+i", "ZSTR_VAL(save_path)+i"
      s.gsub! "estrdup(save_path)", "estrdup(ZSTR_VAL(save_path))"
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
