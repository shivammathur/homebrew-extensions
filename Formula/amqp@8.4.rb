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
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "8d6dae33d8e1b57caf55edef90f25d7605c62a5f895067c379f065a400278ea9"
    sha256 cellar: :any,                 arm64_ventura:  "40e9ffcc138ff33fd4acc68558c0b7dea2ea2ce4cc0b0891a7b6459979654f5d"
    sha256 cellar: :any,                 arm64_monterey: "705139f83296c76821fcc758c72403b4dc136d5fcbec0fb70cf8e3ae4b50665d"
    sha256 cellar: :any,                 ventura:        "93788d2b7606e3c6ff2576bd8454975ad7f1add3906b0c13d03999101ee5dab0"
    sha256 cellar: :any,                 monterey:       "d419fbb7f6e2b66f3a10d7b19ee5e6a3466d3234defc907307b81b5c6b901d04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5c5fccffb318ab1fe846b08ea3d8d4e7299018731e91042e459698c945dd23a5"
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
