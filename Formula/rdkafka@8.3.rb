# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT83 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "bfb0122035af62635eb6678fe9d85973f05596fda46347a013dfed084df78eb6"
    sha256 cellar: :any,                 arm64_ventura:  "37f5bad821e8143c87bd8a1ce638e127dd8a064fd5cbd63b894d6dba06750331"
    sha256 cellar: :any,                 arm64_monterey: "3211451086028b71c9edb0fe23c82d80e076ebd01f65f4a255c790da9ff90554"
    sha256 cellar: :any,                 arm64_big_sur:  "eae4577b15e36c46e6d574516003ac97a1bcfb05414bd4ad7213435137656866"
    sha256 cellar: :any,                 ventura:        "129d5071c4018f1af0c66bed16b8d78bded690f5e49952dae59619b551ed3fb6"
    sha256 cellar: :any,                 monterey:       "8f0a7c2b9949e18d299fefb7490699cbb7dc8476d09c7fa52979529147284310"
    sha256 cellar: :any,                 big_sur:        "46a9c29c8249a251b0a126c31b66fa8e9a822aebab09be13cb840619ba3ca29b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3c3617d17699d0958846d9169b5484c2701cd1c4ceb163aba48f717644c4129c"
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
