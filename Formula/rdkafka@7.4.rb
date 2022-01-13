# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT74 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.0.tgz"
  sha256 "db89073afa27857bcc9e731f7b7fdf0d81c69320fcbe7b82e0d6950703fd4d8e"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "5fed3ece5ba770156bf33ee3da37a1297d3c588bba00959a0f68c0da62cbd2b2"
    sha256 cellar: :any,                 big_sur:       "48f41c78098a6da5e2a7da8f6ae6cf5802ad1f6b5fc0a690db853a2b10cb4932"
    sha256 cellar: :any,                 catalina:      "76715345a1ea416226323040e2278c3023c6570a637e8c3aaa5ae37fc6102915"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b13690dfe9ea2e7496f1cc02d3805a71d7cde266c8581c6c0149aae00662ed7"
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
