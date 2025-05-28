# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT82 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.2.tgz"
  sha256 "8742427ff7c07ba93f940968f7363972ea040d97d847da3b79b4283c2a369dea"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "34344749ab110b62b6703bc48670e67cf940520e3b4be80c2b11892b1c05ad75"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ee935ecea485b7664abe960abe461ce83f309e6d815864becee73f9d46ab5c96"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c82e2a8fbb7b868a38c66dd73bca3b4cec12ffe6e87df8bb2491bfe3d58e3b04"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bd928a7af36bd5a634ec41ac8e8b363d6286d80c1fc1e48b7a19dfec8a4890a1"
    sha256 cellar: :any_skip_relocation, ventura:        "c26e82625a03cab3768f1f4fde497bdf79a34e44509f491bebd2061fdc12ea97"
    sha256 cellar: :any_skip_relocation, monterey:       "2d7bda24af85f6f3b52b1853659ffabec8c9cb9f93df3ab1d29ccec569b435c9"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "2de5d0e4a4fbd3e74ad1cbb6d5a986fff470fc38a73f3b0e27df09c8206b86e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "172740c98ac58adba4d039be9ef02179b1177e5bc90bb1142562a8dbf9970697"
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
