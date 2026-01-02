# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT82 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.2.0.tgz"
  sha256 "5ae624bd785e299523f6132c204bd562cc73066dd33a10a12aa96389f55a4de7"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e471b0270a20669e8cff296566960ad8e3354503ac8d75f2a5a39a124c754a77"
    sha256 cellar: :any,                 arm64_sequoia: "c46468409e8f6c28be518ef4bb657ab441055f75cfbfd12ec44474e86d6727d3"
    sha256 cellar: :any,                 arm64_sonoma:  "2c604dc430840cbf8ea83876381ede42b163af0d0d5c661b1c53a74b0e595fc5"
    sha256 cellar: :any,                 sonoma:        "4bccb8cfc0770e7c7d009e9f779355fac40d4b699a9011a41f226f42a0850194"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "001fbcadfaebeef0fbff2ab7f9b50d83d89633b141a53b80305fa7d980ed933d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1837230ba34d1ac04877004bacba1aa3b2125992e996304982ed54e604a3e34a"
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
