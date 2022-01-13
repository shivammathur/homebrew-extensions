# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT72 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.0.tgz"
  sha256 "db89073afa27857bcc9e731f7b7fdf0d81c69320fcbe7b82e0d6950703fd4d8e"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "301ca89c568a4ca6f36d75953f7a94c3ed9988eb6d65d856fd7dc1daa60c1ebd"
    sha256 cellar: :any,                 big_sur:       "ace80425eec014e9cddde824f0f7efdf46edb084f2954b3070e74179296d7640"
    sha256 cellar: :any,                 catalina:      "1c4a834470293684595ec31b20fa0f6debc7268c8dd601add283e7a2e1846f05"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7062783963f273e81addc670575d907d08a76eab82d75c0f58f2422d55e37ff8"
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
