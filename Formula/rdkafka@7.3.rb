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
    sha256 cellar: :any,                 arm64_monterey: "681c734ac8505b270eaf4060d0d5a0ac7191f583f95b8874a21053c857705bbf"
    sha256 cellar: :any,                 arm64_big_sur:  "b005c11d8e1e5c374ce3e2901f38f38ab400cb7eefd6d3890dc100214570124a"
    sha256 cellar: :any,                 monterey:       "648b8b452981ce9f3ece5fd5a631406caab91a16e19f964fd5366ce5bfe80bb0"
    sha256 cellar: :any,                 big_sur:        "329ebf671bc1423ed8251430169dae7eb79dfc64296debf35aa5951262d0ae06"
    sha256 cellar: :any,                 catalina:       "4dec48f5e38d1a38bcd4f1be546887c994a5aae535a3b0bfec0dd437aca27164"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7a92c4130095c0b0f83162cad45ef1423a7c46b4a4ab73bc0e94d90915ff09a0"
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
