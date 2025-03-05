# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "933b9415f19e89f43c20ba4a9ef81df5bb426eeda31a221b4f4b4a44d03013b8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7d850457b9c03a17893a7920285a3878ea039fe3da5c217ae9438dbe9cf9a037"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ff28f16029e34f6479e06221e460f9c50e4149747af6296a6a8ca76a4be1c4da"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fad603bae7d5ebd5338abb2e593f42875a3f9b59fb7a23a92b6e2d72361699ec"
    sha256 cellar: :any_skip_relocation, ventura:        "c190399318fedf89244def2d77454b275793d7e1c16527f4709a9a5b175a4712"
    sha256 cellar: :any_skip_relocation, monterey:       "490c66c4827466d7346389d4248388f524f1bf321018be190743ce4e0ba3207c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "288b53dbc1f5446c360e04de2697d277711d15511c6bce18beffa2298b7c6396"
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
