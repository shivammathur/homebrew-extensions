# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT71 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "8de8505803bc5b0ebbc4c19f65f7b415350c76da9d7ed1854b570d40efa4aad0"
    sha256 cellar: :any,                 arm64_big_sur:  "489f472ab11821fb7c9219efd96c9465cbc3e8342ada35c5b149034618c770e8"
    sha256 cellar: :any,                 monterey:       "a25190829371ad501bffe3fe7bc1afe928d432b13356c651b3fe81632c284fc7"
    sha256 cellar: :any,                 big_sur:        "585674c128f42a8ad94db234401360a148f675085fba03302293c390fc5000a1"
    sha256 cellar: :any,                 catalina:       "8cf92e45973f5dd7ca9c544eff0fb32fd96c5e3c475c6c206f6d4af51d03def0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c98c101607a65f74654f4e26056ce240a44ebc56733c31881ed6578343b18c9c"
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
