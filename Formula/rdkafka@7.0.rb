# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT70 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.1.tgz"
  sha256 "8488988cf210e45a9822afdc35868cb47909ec0fff258a2f9f4603288078fdd7"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "b14c08ed7c46fc380e5c173704cc49a9bbd0a116f882cee0d400f4f12ab641f6"
    sha256 cellar: :any,                 big_sur:       "95fb880e8b9be71402c645612dd03f01956f85e6d53c99fe564862d3953f8b4b"
    sha256 cellar: :any,                 catalina:      "cab25f3d2a970be936c97c4a82bf8d2a95f322cd6588f0437c4b87ceeb017002"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "afff91a17553136601b82a59d55b2ea93f0dd8680e4f5b88c980e635243190ef"
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
