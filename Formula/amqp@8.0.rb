# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT80 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "22a8f4aebd334d01e9690b1a799769e1981cefa9011c72500675d065227b4764"
    sha256 cellar: :any,                 arm64_ventura:  "7004e324fd9cbe82468cbe455113d47a05c47bf753c4a0ebfd2ddf3a4725634a"
    sha256 cellar: :any,                 arm64_monterey: "4fb3dcdd5c2ad6def9e60d99064e9db032624cb563cd6187462b251aa752a0f9"
    sha256 cellar: :any,                 ventura:        "a19abffd99cb826ed51c9896e60e36ba6656376112ccb966f73eccbc844596f9"
    sha256 cellar: :any,                 monterey:       "e96d02fcc7aa964db640076c9186fdd6eeb37e7118518ff6913373c0c925867b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "260c6574f6f88cbf710b0657c3393415196cad82e4aa438108f2acc59e2b0666"
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
