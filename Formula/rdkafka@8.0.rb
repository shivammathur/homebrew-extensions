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
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "a38f54da7a0deef2d4ce85ae32a4ad0fbb5fb39462c8e765e9de3e69075fe500"
    sha256 cellar: :any,                 arm64_big_sur:  "c95d56ad175e4524728c71dd48088f18334768937d008fc099f849af91b218f5"
    sha256 cellar: :any,                 monterey:       "768139b39fa2a4ed6a8c134dd7a17f130506f957a0a1483cd12891d1d80798b9"
    sha256 cellar: :any,                 big_sur:        "494caddf5dfbbddd5e025375dba1e25ec7138936cbfde0faeaff3923b1ab0d4a"
    sha256 cellar: :any,                 catalina:       "b6fb2332de7a9b2dba36c2b4a94cf9ba445813fb0905f5c4dc46c60bc618d2d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e8586eed5796e0526fffda93359a05f8c91a03c5366d835face02e5eff86d8a3"
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
