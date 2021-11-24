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
    rebuild 1
    sha256                               arm64_big_sur: "15f35d53b2d8fb30d726d7cbb85df20086ef341ae1fb2ddf9e2910381219d94a"
    sha256                               big_sur:       "4f7a6c131641e1e9f23fa76241b35bfcb49f960a73121fbaf41bb480f41776c5"
    sha256                               catalina:      "61ab9af1af494ee522617dd7d7d5d9157dd1dea8941aff5e7c8eccb998798095"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f72005bb07d5c42ab76bd129e5bc3f8f571ec71f5bd1a4245f1b8dd0256acbe9"
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
