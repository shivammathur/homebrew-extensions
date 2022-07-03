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
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "a1addc9540fc5ca91a8b98c247213dd28a45a87513c8092bb1ed4a28e228a329"
    sha256 cellar: :any,                 arm64_big_sur:  "66104ff4c7f98c5aae96a21740d4b7b61a660b2e6d60ade7de49ee254ce2a402"
    sha256 cellar: :any,                 monterey:       "a88b07a3ac1a1070cec3aea4faeace0158e426f66b76c550081bdca8e31b2e4c"
    sha256 cellar: :any,                 big_sur:        "23c48e0710b060cbd3636642555195292f51330b98a2253907abf6df90ace4dd"
    sha256 cellar: :any,                 catalina:       "d8bd2b4faeffde0f81100f9baaca8182cbf50f94cbf3d84b07233bbe9488b948"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d0df1b7e28a3a5d5a7474189f4cbbc2c01d770da6a7ca88ba942284463def6e5"
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
