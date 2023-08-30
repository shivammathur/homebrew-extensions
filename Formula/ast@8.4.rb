# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT84 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.0.tgz"
  sha256 "ee3d4f67e24d82e4d340806a24052012e4954d223122949377665427443e6d13"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dc3b491d9ec1a419cccb81b4e82365e61508314027902cfeec77f3979997f05b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5a97d8b6ca99979e1c8c7ca023966a3d30af40289b21970c924ea97c8e2f86fe"
    sha256 cellar: :any_skip_relocation, ventura:        "e5812487c077b29161c3bdc6964033611e0d26523ef9a9395f74fe518e957cfe"
    sha256 cellar: :any_skip_relocation, monterey:       "a79f17f04f8929753c50b104feef35ad69ef8d49965a28ffc3a05a9c4be3a72f"
    sha256 cellar: :any_skip_relocation, big_sur:        "75aab8d491959bf82667d0c24e67ce16f923a786e8233a1d8b062620ecb7db0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d1dee8ba0c58be54179a586634d54e02b345eafff24eb60d19cc6bd207011640"
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
