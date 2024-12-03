# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT80 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "de9ee4fe0c04ccbcd6cf2188ceddf46181d969b80e0fec2ad28a7a6e3445b726"
    sha256 cellar: :any,                 arm64_sonoma:  "587db35f548c2cdb3b14f281b603e85d9f9298536333e05c02f3959be53ae319"
    sha256 cellar: :any,                 arm64_ventura: "1625ac4ab4637f52aa85ebdc69b272d8a41d786904f13c89bb4d56a29957fd54"
    sha256 cellar: :any,                 ventura:       "41edc0992cd236bda886c4fdce935e1d5cbc3d48607d345b12bd2d6dca67f768"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd2b7a84f989f0524baa74c015f289345ae053fb94ac85c1b6ed8f1d1d2c6612"
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
