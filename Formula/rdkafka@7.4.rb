# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT74 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "36271c8df5fab902d7ce609b406b64d5880617a89cab2c6ff2a1977342a94a69"
    sha256 cellar: :any,                 arm64_big_sur:  "ff3b82f841c0547bf1bd3104bdc0407f7942e6c74fc7c938dc2b7ddd3582c8d0"
    sha256 cellar: :any,                 monterey:       "9b54cf266878f420414d6591cc424eebe3bb16803e2f78d558387ca386377ca5"
    sha256 cellar: :any,                 big_sur:        "a0609907d9d140ccd94e2a16b00c66198c6bb88014b1c2e15f2d22d0ffe9ea57"
    sha256 cellar: :any,                 catalina:       "9cfcacc03ef0b81847cb2ebf1b874b40a9dd538d5e72d048275fd735f12d3053"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "72527689347924c01feeb7fde3418d3a0b038a053a344b340942e3eb13109e57"
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
