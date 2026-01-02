# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT86 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "0fc9a23b54010a9ba475a1988d590b578942dbdf14c19508fd47dd09e852ab0f"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4c2f43e1480176a457690b2572414127d4b15a4c03b3f64afa988598bdd0b8d5"
    sha256 cellar: :any,                 arm64_sequoia: "c66bec7fe6e96d2cba35e42ac6dc85b2c450d28ae877ee157878e3cc6c4b33c2"
    sha256 cellar: :any,                 arm64_sonoma:  "7a4753749b41e6288005856e188e3f3a3a3f79741887388e2d6f9b98a0240d99"
    sha256 cellar: :any,                 sonoma:        "ddc26bddb7f33372529029dbf2ef503436a8a2c8b9e98596164c7686f062b5d2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d0367e87b304c2a6e4c27d1cc1adeb93823f214238b3043295168fd57f032552"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c0d3127956f7819ed5800a8f251e306418241c353cd7724df1ebb075a5eeccf4"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
