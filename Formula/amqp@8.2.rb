# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT82 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/4090bd39b91c4ad8bb671f6b4c6161eaf89da3cd.tar.gz"
  version "1.11.0"
  sha256 "a0c40334cc0119727334b71ce236aee16e385e2ad087d7f98aa146f00c46a7e7"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "96a7306bd481d4e99f8d9ac98174ff7760b0aa9145b033fc9de8dfdd28d73891"
    sha256 cellar: :any,                 big_sur:       "fd167403ef146300a9281217b498819675213ea0de77fc0f436c431b3e932a73"
    sha256 cellar: :any,                 catalina:      "21dcdb4ef23eecb55f21bf1d078313390f817994f587c93fc1e7167cd4b86a94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b1e38ab83fce538c79e517a8a94999e91f848cd99dde241d6946e12022da23b9"
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
