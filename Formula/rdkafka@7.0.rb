# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT70 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "6de196ce1c0186c1593711bed5236deb0987dd5fffe99c0a7c85b433988b1905"
    sha256 cellar: :any,                 arm64_big_sur:  "16b849ab5f94d1187a11c6441495e2165bcea5a98c24c5ec595f2d71107ccb40"
    sha256 cellar: :any,                 monterey:       "45012b525474dffb1ee89619de90e912ebc0c7aa63587353f0e51dd2013b0210"
    sha256 cellar: :any,                 big_sur:        "566ddfb765ba73237c1242618776157d454982d582869a2d0ec5c467257406a8"
    sha256 cellar: :any,                 catalina:       "6b596f7e0e60206d7879807dffdfdd71e5f6002733880d44822a80684bb82c48"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cce585fca1b6e6405b5c0fec56e900b4af556aab998debb0124dda81476b5912"
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
