# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "ff2cb0f43b5dc704d10cc4b007e624fa552c810b53e35f7478d297617e4329b2"
    sha256 cellar: :any,                 arm64_sequoia: "d36e997ab2b829162243235a21c5dde81e6a37a284063daccc30b6f25f304b12"
    sha256 cellar: :any,                 arm64_sonoma:  "bf1acc6c7d09d021762cec71aa7ac40b9d1fdb3b5506b9244233711d9659583f"
    sha256 cellar: :any,                 sonoma:        "abaf50064cc5cd2fd660ad82785459f02010fcf66d6bcd825e0c74b0cc19bd13"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9288c34d3024c7043d7916efb4e52ea4725cdcf3ff44b7ea71dd31425ba6a020"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b2fd6a413c8749ec3a825a352fe85b9acd737c6e285d7e7452e1ef54ef7c03b"
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
