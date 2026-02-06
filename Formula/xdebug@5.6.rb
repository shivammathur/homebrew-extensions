# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT56 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "53d32e6996a6ee4b70602020831ada06909c6e04590be2ab8a0a9f7f8868a882"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "46fa1ffb1cabb564f3355b214a602b02cfe74d091be8d6e3dec5554890ac9e40"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7eeb0ffa62c2cd08c291762f1b3ef34bd70c573af952c345f6e1fef253270dbc"
    sha256 cellar: :any_skip_relocation, sonoma:        "da1957b11216c8a8f4b17a84f3fd63058fb75be3f44b3bf83dc76973589fb534"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "25109ed2684223609dd44e97cd8971910c2c5bc1257e2c7d94b8cb86f48dc282"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bee0b8a7a9826c6894ae414945f30c549d939a9c5052b0d4f10fbd59b70eef22"
  end

  conflicts_with "uopz@5.6", because: "uopz for PHP 5.6 conflicts with Xdebug."

  def install
    Dir.chdir "xdebug-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
