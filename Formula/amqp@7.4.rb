# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "eb2f4a0274773bb1b4e718a425d1971166e45e932ba38a8f6663d150f8c69795"
    sha256 cellar: :any,                 arm64_sequoia: "42dc65a01e5b705d57ddd9e7645b9edf06b736bfb24b24dee4aec7a8f7473429"
    sha256 cellar: :any,                 arm64_sonoma:  "17dffbff2cbab309be8fd93b7f7f1c384999ee05fd476d2914abd3f251f0a3fe"
    sha256 cellar: :any,                 sonoma:        "640bb7639a6d71e833d2655300305e648017b3e7ca56d185db9a21b8a7c432e8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "79723b3fae0dfa6c3f0b4d0f8b0e25885f28af41752e80b8cfbfe0e416e13857"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "375c079ab612cc2d6df9cc46aab43dc04bfa986eed544449b0705b6d4f0f727e"
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
