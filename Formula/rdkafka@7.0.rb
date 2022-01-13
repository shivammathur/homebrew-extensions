# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT70 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.0.tgz"
  sha256 "db89073afa27857bcc9e731f7b7fdf0d81c69320fcbe7b82e0d6950703fd4d8e"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "de0591fec002a796579607ce13f5fee278dbf7295a211d571dbf9094e82fc3c4"
    sha256 cellar: :any,                 big_sur:       "a9f5001450655122018a962ffe19def8b614832b73819b592e58f7b596cff5e2"
    sha256 cellar: :any,                 catalina:      "c06c73ff934d810275c645124caac1ace6605fa5a5ecc7719cca15dcfb4d5add"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "38c1dab291a3662e762c90920ba39bac1bba843334a36dd873d1057a91c40f3e"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
