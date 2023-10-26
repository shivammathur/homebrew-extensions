# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.4.0.tgz"
  sha256 "47810a0aaa20c1a3cf0a2d7babccfa1870fa0fc78d30cefd45ed808f89d47619"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "35878f077a03b100305c39433246d7c75149f4c1cc182793f5c8e3d69279e0ca"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fc677ab675f57fd5f9485e2bd43e2a5421113a59f75e2ef4c8c730338f6f4612"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "89635da364a9cb7516adc26f0d5e145e5df6b18ce078793f76ed7dc6da59928a"
    sha256 cellar: :any_skip_relocation, ventura:        "e38e6d9ddeb54373328489afdf933245dff36d0cf4fb6275aaafdc277c54b186"
    sha256 cellar: :any_skip_relocation, monterey:       "f1f3ef5c6e0d406c0ed51a406c723d2a5e8063f584a80117f7b5ee8db1b61191"
    sha256 cellar: :any_skip_relocation, big_sur:        "8d5b697068ecb025377117423bd25320e923155416e3b0591c63927653e67943"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2e6df5869fca18347d151b9ee6b173a332bbc32e8f395d90e2096c6fec6920fc"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
