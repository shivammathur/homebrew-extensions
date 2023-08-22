# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT83 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.0.0.tgz"
  sha256 "2de740da9a884ade2caf0e59e5521bbf80da16155fa6a6205630b473aed5e6dd"
  head "https://github.com/php-amqp/php-amqp.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "d47ba75662dd59aa71ca62092fa2b72319490dd600ce6ade24239ad8ba09c9a0"
    sha256 cellar: :any,                 arm64_big_sur:  "c7aa8701588b582a4d482a72f5ddd11379fba7e828f1728083938472b034be3c"
    sha256 cellar: :any,                 ventura:        "9fd7b1c0fd7269d259bbf10eaed12bb7e18571a3c76a6e5c4b07b5bee4102c7c"
    sha256 cellar: :any,                 monterey:       "c1e42bf619b51a789b913e7de8a5c4a7cace278bb5b2686b9cc901ef86faaf0f"
    sha256 cellar: :any,                 big_sur:        "688e6373481c4305fc4be6ff3c87f1ca3bc48a3bb01fb3661d4794c1665f7548"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6130d2aa5b1d9f865261e0419f84b5f7cbb46e2a08e1cea22c26cc86ba2eec37"
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
