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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "659f31a03d779179632e7584b3db08099b3b92330b3021a9fa380968a4fc4e95"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "83cbb4792b80681315c615609024e2b29b410ed36894ea0e6c98cbdf36842f81"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0d723ed2cd42461adb09310d95b0489e72d59206f25c5e7b5a2fd2ba386faf9c"
    sha256 cellar: :any_skip_relocation, ventura:        "2a08908631e34c8c0bb5c3199e4205e256ae5da87056af257f6dcd4f6bb8cc69"
    sha256 cellar: :any_skip_relocation, monterey:       "c89616edac4853e390a242e217db48633761322eadc900433a369294cdc679c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3bb762b18891a3cca795e02297b3c0e5c47e1394839aa25ddecd1e4f3ea0d4ad"
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
