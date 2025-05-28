# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "07ec5ad89c19597ebcf81f94bde888c99edb1f6f9c28612d71792cb5908fab81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9485b4e77274115f84c258a2a464bfdcd2ea9e6d4e69d42fc7f18893b68b8007"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9fa7b8063a8b90ef132a6458a4a31218c3825031e15816d9a245eea82f74b4e8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6a1c53554deb42de936b6580ee9c7a256711739568c01afa3ee0e925af2300f2"
    sha256 cellar: :any_skip_relocation, ventura:        "538e1604092c1b5e08a4dedfd15830b90bdbdaabe76330015d51239115d89bd5"
    sha256 cellar: :any_skip_relocation, monterey:       "742d98d534b9f93e757c744adf51e4621ef769e461a37062255d9788b928fa2b"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "e61dd558c6fbf62d66bf99643a7b651d59324b800084411e2d396c6ff4f1ff07"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c983f0f7c90ba5c3fe45fd5b40d54a360fc4b69c28b834a101a1bdf04af1c25c"
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
