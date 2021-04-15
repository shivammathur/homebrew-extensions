# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT56 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "41becc4471bec61058f9684636e5b7b5eca8e8b7ae7c2aa4d6427c69ac7b8985"
    sha256 cellar: :any_skip_relocation, big_sur:       "cf4e988a3805069c2fc0ff876cbda1ef84ea1474971a3b358122bf7109956b40"
    sha256 cellar: :any_skip_relocation, catalina:      "ddc7ec2f15a6615f8b1c07da9819e06419801d74c5b0a2be0f3b44ec1a08699f"
  end

  def install
    Dir.chdir "xdebug-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
