# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT81 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.0.tgz"
  sha256 "db89073afa27857bcc9e731f7b7fdf0d81c69320fcbe7b82e0d6950703fd4d8e"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "eb1a800c512ca1cc3941ba0c4566d79c1fb6d7ce5f43004521d5c3dfd3899fec"
    sha256 cellar: :any,                 big_sur:       "5852e4ec8dbadc7626f9d486f4fce4d7359cd967d85fce2a74dcdb1a39ad6cff"
    sha256 cellar: :any,                 catalina:      "3c3cd97b960f91cd96e051ac17f7af97264fc12db1edfda2cbf9047237e3486b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba56e4d3fdbedcd525d694ced92ee289243eebbadd4d5be2c995805597a3f0a6"
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
