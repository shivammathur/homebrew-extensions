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
    sha256 cellar: :any,                 arm64_monterey: "8b4faa8df3dab817595ac91cc8e60c99cb22b377f1d033c4392e6e8ffacd555b"
    sha256 cellar: :any,                 arm64_big_sur:  "b46d40174da64485a65cdeb288dfacbbd4d7986617395be299dd483144ae0efc"
    sha256 cellar: :any,                 monterey:       "bdca57a112dbaa20573e1282a0782d79db6ac5df057aa0a35608a438420c20f9"
    sha256 cellar: :any,                 big_sur:        "15a3a17b1dc105ce5d4b361bf36b5f1399fad9dca808ee45ea1ffe97b768477d"
    sha256 cellar: :any,                 catalina:       "d7f1d1b1417bd70980cd3993690355c9f3b3c53f44dde905057c49f6e3da5997"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ba548abb845a466727ad0819fccc86003352de2bfc7200c4cae0f20bdd9f2810"
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
