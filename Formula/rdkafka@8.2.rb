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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "1c713d9bdc6d231d5f5e79493033550b94879e03d95a2f349678e899773e4ef6"
    sha256 cellar: :any,                 big_sur:       "dc9ebcf0c451ac88d7aa2b5c3a7d20516515c375fe3f3598b18c3211a5a4d101"
    sha256 cellar: :any,                 catalina:      "7d3c19303c5240ac0633b4a84060390ff41263f3c9ff8f94fa9e5c91ffdbd822"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2789642d30745937e648eccf3c24d151362628492c36c1e2e6afbe4bd39722c8"
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
