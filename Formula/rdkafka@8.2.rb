# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT82 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.0.tgz"
  sha256 "db89073afa27857bcc9e731f7b7fdf0d81c69320fcbe7b82e0d6950703fd4d8e"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "1b975b6a12ff25fe4065b171a871c360acd31be904102e47d7c01a2d1e0830c5"
    sha256 cellar: :any,                 big_sur:       "df6d973584ab45c01c40c2bea14e43f43ff6878e34c93f594b27cf3534a34972"
    sha256 cellar: :any,                 catalina:      "404b6c0c4524ba644c8b35d65f82caf492b8bfd8f70d32bc4fd686f0ee908570"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad8d45ab8e456271bd13c3e062783f04cabf282d54186307a713df08047b8310"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
