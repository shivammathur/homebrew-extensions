# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT70 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.0.tgz"
  sha256 "db89073afa27857bcc9e731f7b7fdf0d81c69320fcbe7b82e0d6950703fd4d8e"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "894b636789e3c4356a63e6800cc4ecde519b6f055c3ba2f3bd7dcc06a06aefcb"
    sha256 cellar: :any,                 big_sur:       "642936ea566d168aff3d0ff13b4b61efa088c79d3936bbf2b8e1e026c8c09018"
    sha256 cellar: :any,                 catalina:      "b219fd390274d7fb00f5e1c99ac548b371ada2becd54f88fc9988b44f57fc9dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e2f4063ff5a8a560a1b5e7b15ac1bd3d3cfac7254df17d4d79cc7f3ca06b917e"
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
