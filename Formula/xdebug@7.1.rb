# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT71 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2.9.8.tar.gz"
  sha256 "28f8de8e6491f51ac9f551a221275360458a01c7690c42b23b9a0d2e6429eff4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4fa906e4e575df3df5ecbdf76854c388817ad014689927ee6b202e102cb5efe1"
    sha256 cellar: :any_skip_relocation, big_sur:       "a47a76c5abceaf29d9ce37ca5a5cd299dd604649517a894e885486789f2b7b75"
    sha256 cellar: :any_skip_relocation, catalina:      "6bbd0da640e9b1060634f15909ae53804efb34afdce1fcb0793cbf7bc7f2fcb3"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
