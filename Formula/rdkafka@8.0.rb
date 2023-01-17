# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT80 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/rdkafka@8.0-6.0.3"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "89f1d603e48453f14d460ff990e8ef7a7566113e1c46358f97c5c81aacc913b0"
    sha256 cellar: :any,                 arm64_big_sur:  "b5bc9b82403e0b5cca32cb0536e5d227fce6d98d0bb3deaf2e3b078108c57a41"
    sha256 cellar: :any,                 monterey:       "98fb9005f7d6660c1d77cf6d7ee75fbca17dad642ff30a40b4c0e028df5dc50a"
    sha256 cellar: :any,                 big_sur:        "04305f4c3cd970b6e80417936be0bef1ecc61636867e50aafef32f0e8b0543b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7779ee2175c31ba535b69285640813f2dfaeb5cc5294f321e75b238e5440e0b2"
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
