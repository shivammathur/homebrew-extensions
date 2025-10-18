# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT71 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "040c55c38964c9dc3a5844b7201655ace6cad2580364e6448325e8d0f05e444f"
    sha256 cellar: :any,                 arm64_ventura:  "cee2688306e80f7d84bb75fb919b07d068262ba05e13fc7848436e2606216e8f"
    sha256 cellar: :any,                 arm64_monterey: "a90418e350479a71140678a8ef418bd6ca4e116f3570c4d46c68d405cf5a3f8a"
    sha256 cellar: :any,                 arm64_big_sur:  "fd58e3a33b71521431d97a8455a4247e5908cc1639f780d2c585eea33d1f38ea"
    sha256 cellar: :any,                 sonoma:         "9e6f02e6aeaa80f251cd4e58d339a6199f5d7b719e92b4e67aa080f1568ca9db"
    sha256 cellar: :any,                 ventura:        "a0584bd57d364f5f3b4ba0c82de6319245301e9857a7fcb5c353015dcf7e6105"
    sha256 cellar: :any,                 big_sur:        "e484c73c44cc9a847585d32f3d990ff21307871f8c37c5e314537c5ea0ab83e2"
    sha256 cellar: :any,                 catalina:       "80dfdbb590e50a5c377fe82016217bb9068389bce72c067a2bd25e6764d5e343"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "c7833729038cd445daf1f04311bb120f38a65076c46edf5096c339867a1a05c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "87907253e94fe8f69a8e1eb13b90ebf57235e55e9146953eddb2582f23b6a6c2"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    Dir.chdir "amqp-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
