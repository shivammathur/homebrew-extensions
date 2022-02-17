# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT81 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.1.tgz"
  sha256 "8a4abe701e593d1042c210746104f4b04b15ac98db6331848eed91acadfcf192"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "57e478232ffacdc7f9c72549ef8b538e4d679a80d415b50dd83461c0631b6849"
    sha256 cellar: :any,                 big_sur:       "03900fcd41342465a8de431ad887c7d3f1a6200e200c49db223d092748b5a9fd"
    sha256 cellar: :any,                 catalina:      "78deb96634a0d5f09dd981206e4a556b3815c7ee442f01e8912873bd5448712d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0a40526c8566c538b131267e49367f02c4c0f4111beb0b5c3379541fffa6efde"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
