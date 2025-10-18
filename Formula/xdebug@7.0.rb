# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT70 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2.9.0.tar.gz"
  sha256 "d388ad2564a94c52b19eab26983c3686fae8670e13001b51d2cc3b8a1ac4b733"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "d7e798f793890e07040243e6cc81d5def35f72af422bd7704420e0e6d70c4992"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a0df135fd5b12bc811b6cb594d1e0152799b48365d36a72c71f2f955ba038dd0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "91b8f8640ced0ebb291e73d8fb04020ab37fb3f22684e07cdc476d285e123538"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1138c70d767e83766fa2dd3228435be4eaa4a16aee724d0d87bfc6ddfc16c564"
    sha256 cellar: :any_skip_relocation, ventura:        "775a21714729a2631e2e6a87066b7ab43be00b05fd814fb54abfc5591de7725e"
    sha256 cellar: :any_skip_relocation, monterey:       "9a6a6c1542c7b2b1c51861c2f49ba0d9b3de28b0b2f4058b61e10542282d1b6c"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "b64556b29bc1d6a48c998bda44ebbbc5f4a869dfeae6759a3f3669630b1db4ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "17afb2eb312fdaa4733b22d4bbb9f3ed79701ca4304b7ce393e8e60ae532c9ea"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
