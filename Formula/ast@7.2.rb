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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "644e1cb653df0463ca41ca1bf1ba0daede2502d20e05d682237b737fc4dda39c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bff056684e147625f167555657baf87811ee953e0a05565fcc6922f8d268173e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "55bcb2951345c384b2be1963eda243382f317ead418c312c826365dbb3a319e9"
    sha256 cellar: :any_skip_relocation, ventura:        "0f9687baa56362873fdd4711023c641bcc5aa9e9712a934c09e9a0c90da6408b"
    sha256 cellar: :any_skip_relocation, monterey:       "ec7dd1b1fef7d8b6117c31e2bd564b826fc349741b18683db6a3dd251a12dae6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "55ea5278d077189ca3babd516812ad207a16b8c4466ef46479ddcd202ae88377"
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
