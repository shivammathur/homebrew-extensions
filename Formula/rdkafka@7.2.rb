# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT72 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.0.tgz"
  sha256 "432fbaae43dcce177115b0e172ece65132cc3d45d86741da85e0c1864878157b"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_big_sur: "103fde7c9c1ee84ceb703622facf6d27ee0dce3bf912db731ea74a7f41c2fd5c"
    sha256                               big_sur:       "8fefc40f48e2012f8f96d907dfa04748aca0eb3c406cb4dc9ff30d530c9fcecf"
    sha256                               catalina:      "4391b9be7c498cd9d6eb2efd9285975ac6671b96167b23bd4412370ab8adcdf6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ebd4734835063efd6475e505ec1a1d28b2076fa1d55dd9ec7fb3e0cf79034bb8"
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
