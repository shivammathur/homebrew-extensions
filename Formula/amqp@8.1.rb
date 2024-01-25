# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT81 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "262e5e84bce230a7c2df6cb7a9905b990b82a05c082c2d4a668dfa58c0974018"
    sha256 cellar: :any,                 arm64_ventura:  "87fa5ad5f5df1184670c77d5a5ce40c36fdb314dc5e878fcd34d3313be2ec0f8"
    sha256 cellar: :any,                 arm64_monterey: "9548dfc1b9af3583b0cdda0014d8d41a53e8a890ced2b0d12534246bfc897b08"
    sha256 cellar: :any,                 ventura:        "6193624f9a515ff04eb9f548c52f02eb6279bff219cfe1a755c6cbc392dd83c1"
    sha256 cellar: :any,                 monterey:       "ba04003906b9d6738f12af671d01878e40c8ed65e431c050388eddf76f52cb5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "60b0b95ec9d58c270288c72e289e34f730f4864036d00b53dca733c22906bc6d"
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
