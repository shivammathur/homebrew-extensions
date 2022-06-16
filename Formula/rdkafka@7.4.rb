# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT74 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.2.tgz"
  sha256 "faaf617f1cae0e85430306e078197313fc65615c156ff16fc7fc3b92de301ef5"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "65db2d5e5cbe7cbae8e6da84837f03a44b201e73ffef872104362770720160e5"
    sha256 cellar: :any,                 arm64_big_sur:  "501e955758179e7f75d782812817c3e321ae0773c062e17f56272d107c74a92f"
    sha256 cellar: :any,                 monterey:       "2aaa632c31fe2dca85cec56c8362a2f3536bbae82aa0afa5bd5803106fcdcc9d"
    sha256 cellar: :any,                 big_sur:        "cd7931bfcf8bf6c2ca4868e369599664696e2e4028f2ce89612cd84c5a2f010b"
    sha256 cellar: :any,                 catalina:       "aae8e368ec4ba84a633d76c918b8a73f57ae01c7bac8624015276e199f8b7490"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6c310147a91bb7352826cbc0425467063301b79ba3aa3dba24198f21048f51d2"
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
