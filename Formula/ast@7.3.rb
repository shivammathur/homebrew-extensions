# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ea9c26e0e075acd3010519dfad0bc1b77306ad38be7bcc729bb70627aeccdf55"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "57ce526c1afe16bce46ca9c26a8e7a9788b4e15e7cdd2bacf07ddba3bbb9bf0a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2d2f89391a8e4d325ef5875ef1df5062fd3d95a07b91e5499663cab304de05c0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "12aec5cd2262aac1b58e485431841694e4489a7565ecc70420611cb907501f3c"
    sha256 cellar: :any_skip_relocation, ventura:        "3a296c11ea3ca74840db814f920f5ad290732178a83e76b1fa48752a7c2735ee"
    sha256 cellar: :any_skip_relocation, monterey:       "e5f3badeb0f820c2f9df89997425f03cdfb1f748d0d8b5ab5a40127179d8b03f"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "b1dccf889e1197a7289bd45e8831d740bd65e896bb299273f5f95b0eb1cfe929"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6c96fa75b29a7d1d99d1437197b4ffb46f5cee3b8e3ac32d7a56c850b3e93e6"
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
