# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT80 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.2.tgz"
  sha256 "8742427ff7c07ba93f940968f7363972ea040d97d847da3b79b4283c2a369dea"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "81f939177c27d0c2ca9f99d4d4a058f53a66067512d1ae0e4eaed779af994390"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "597678cdc9561fb49707ee677b9868c82b2b6200cb278065c9c8cf99c9dca15e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e30437ece7305669d8368e3d2ed5c4f7491224288d1f026411942ff461a9801a"
    sha256 cellar: :any_skip_relocation, ventura:        "e52766bf72e707b1d34e15863d7b5e6f9ab7ccaef174b9b60b1175c3f9a0c04a"
    sha256 cellar: :any_skip_relocation, monterey:       "0c7e1186d0377ff9ce51fa163dd04c26bc9a7512b9985974904b227e4f58d640"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "73550cd7acda465474a4bfe54d163aa0e7d8cbac08cdccbaa5ad610f487f2de6"
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
