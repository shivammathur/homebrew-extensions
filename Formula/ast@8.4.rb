# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT84 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.1.tgz"
  sha256 "0c55e09a4da43b9cc1da72ecb4ae892941f73e157b73d46326bc6a5ed7fc44b1"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8353126084a8a64fcc45ce9772f9bd2edc613dc7b4e0f8e7fb2eb93485528c18"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d3f7a696d114d7851b8aec5b07acc3b63668b8bd8b6c509ad5f8c6f5618c9a42"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f3e8a93e3b33a67a9b0c693e213e71018a2cf2ba5f553b20a8ec4d5b664c68b5"
    sha256 cellar: :any_skip_relocation, ventura:        "2fcb0ba06925e8564612a4094b98fc0f636d51f41c532158ffd1a8200d2cff2e"
    sha256 cellar: :any_skip_relocation, monterey:       "7d27fdc169109c7b317dde45510a1cd6f6838c6fb1d312bb1002a888a684fc1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "30c1544cb8f0dbd321eee577f661685981e93c6cf1a33e7cd7c5e0ab503c6dd3"
  end

  def install
    Dir.chdir "ast-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ast"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
