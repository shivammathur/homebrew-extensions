# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT84 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.0.tgz"
  sha256 "c3fffd671858abd07a5a6b12cb5cede51cc4a04fa7b3a25e75dc8baee14bce01"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "ccfdb523ce0e8adf6e1d1aff4ce9d7d0cc53ceb5a34151920ad22141592130d7"
    sha256 cellar: :any,                 arm64_monterey: "e58e1b2461e71f826c3d470b460b67472eea2f8a1f4219f101418726911ebc6c"
    sha256 cellar: :any,                 arm64_big_sur:  "323b0ff7dbd72f76707406791904fad24d5811b4a76be1cd12b26fa9fc7e0221"
    sha256 cellar: :any,                 ventura:        "450d9eb5f3bc75aa91c32dcadbc507059cda3a297b136fcbc72e0301980ec984"
    sha256 cellar: :any,                 monterey:       "ed64f9ae038432a40c971faa81742dc48b9f5ed6a34cb6683984efe24bdedb9e"
    sha256 cellar: :any,                 big_sur:        "29db6ee57f3707bef92bb1c2de4cfe6ad01b49c1039639f6464b2fa6e8c90bf4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "23045420408de3e43060edae6b2154a2c9fbfec37852251a2f6b96021534064e"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    Dir.chdir "amqp-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
