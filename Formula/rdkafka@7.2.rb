# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT72 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/rdkafka@7.2-6.0.3"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "1ce3291ff7f4d172305043ee5769d1440bf9576a3deca871022979d76e16cfe8"
    sha256 cellar: :any,                 arm64_big_sur:  "f0a1eea2a6abf8ab830e125f2f07ac71daa9170b00794087db3fa6a0d4857150"
    sha256 cellar: :any,                 monterey:       "5e851969e3d25391e78758ef85f1d36aa36f17c8f9c0f3dfcd822e9f465e6707"
    sha256 cellar: :any,                 big_sur:        "306718e004d78dadd9da2033471fac8bfe995f98f23f3e6ba9c3146a1f058928"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5d4b74e82e5170243428d874cb67ae3173448a39a87c50032329f4a67862675a"
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
