# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT84 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "0229d72d441a467dd10cf1fcc97c134b7cd3260d2712abe65969727fc87b41e0"
    sha256 cellar: :any,                 arm64_sonoma:  "79f01bfdda45201fa3e1e88c9f2f64a0483ed7225df4f698580d2be846370f0c"
    sha256 cellar: :any,                 arm64_ventura: "431f0bb35aaf87e284aa440c1d2a589ce8147a77e13505f99687b4ca33d16c5f"
    sha256 cellar: :any,                 ventura:       "1b6c1ab6b36647b1cd91301b6b9b4dc84565dda4c06cb25fe894020c88e5f2b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1dc8ad4944f517440c5175fead782418f51ab58dd9aae365b1588842086a6df0"
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
