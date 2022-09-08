# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT83 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "35e274b78019deb3074d721c612caa613e2905e4ad2d188fe4813110e1d9eae1"
    sha256 cellar: :any,                 arm64_big_sur:  "ef6acd5ec760d9e7e633f4a8d3a9f1f85bb223d38c2b1dd40c63b90cc9911e57"
    sha256 cellar: :any,                 monterey:       "ff7ae1b2dd2acac492863897d387f6c9a89405993c5c1daab7f35d3a51f91eb0"
    sha256 cellar: :any,                 big_sur:        "596e7bdcf044e385010e954ef409aaeb37c5178d72f6da0b953c6d5817d7e2cc"
    sha256 cellar: :any,                 catalina:       "14e5ca87e327b2c7d9aae18e2e79254aebba12a89ab608a7622428ef3e24a18f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c19b1e5cfd4debf8ec7515a38514496d90ee0c586843d681ead065bf5d734af3"
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
