# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT74 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "2fb0f5644ab52ca7050f8e0f7633b4cefc16776c77bb641373a8da0034cee1da"
    sha256 cellar: :any,                 arm64_ventura:  "2c4032ca5e1b8bacd9f75030f201fe3737bca587ef59ac3a34f6da8138ba4b5c"
    sha256 cellar: :any,                 arm64_monterey: "3ad7447c7aee50517a652e4e886ffda48a876eef3e9976af6b5c9f4d1c7c6d70"
    sha256 cellar: :any,                 arm64_big_sur:  "cfde739ffc7adf1cb64c857e9b1ad8aaebfff2cccd724129310d9a918d6c892a"
    sha256 cellar: :any,                 ventura:        "1d015d43787019caf70695e14e3e38a2a47d420531a55492e37d51ea4e3fe6ea"
    sha256 cellar: :any,                 monterey:       "3f4e3f312e8139e271e50e534afd4e0c78ba37f0d24d4b2179371ffc0d9f9517"
    sha256 cellar: :any,                 big_sur:        "fd5b631496990f6603b1cea5c1ff2456961db91fb03e72e5907f67b2920c7f50"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4e8d1850f7513083bc240f2867779238d6d3285de94d1998cbc1da74c6d8a3b5"
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
