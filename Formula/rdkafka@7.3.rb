# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT73 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "474788e380ba4638b033055823791d6d8b045487ce79b7325d3226597f75d25a"
    sha256 cellar: :any,                 arm64_big_sur:  "c6e31fdb6ad88f2f249c6ecd01825d02bfd31b92f03fdf6716148bfa291e20dd"
    sha256 cellar: :any,                 monterey:       "e9af73bef4df09f3e89ccf2fb09ea0bca1145e23e86c757ffd9e20d1dff4238d"
    sha256 cellar: :any,                 big_sur:        "ab1cd737227f1dfd0b84320b1cee1c87930b6a1c1f863c2764fed54d901b8d39"
    sha256 cellar: :any,                 catalina:       "45210149554251770c933f13101419c2f668689dfae09884450edb93b30ae766"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b7806fc588772de6d3bd5c2bbc170936f8a9a9a3318a875f584a00a09101b903"
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
