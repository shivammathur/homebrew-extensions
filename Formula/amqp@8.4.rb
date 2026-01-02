# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "0c66bbbec6b662d81e960a887e7627578bfc034987e7f89bdebd1e0386f8b0c1"
    sha256 cellar: :any,                 arm64_sequoia: "15b6e7f7c9dc0c1cff3222f51bf70ed27e08351f98ba91c4f7364d947607fa7f"
    sha256 cellar: :any,                 arm64_sonoma:  "d6017de1c280853cdc3edf672b9cccb47c276182a089e728e010bcb201cc7022"
    sha256 cellar: :any,                 sonoma:        "361c2e53fd0b652163329383edf53239d415ab322e847f68b56659ed42e145b9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6d509c9aa75fd4387d8c7186a58dd4eff5ed8e18aa523740defacd4eb36e703f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cf8d8f43b0e58c254e96ba8fd11a382273583380c7972d6f0f4095f1e7815773"
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
