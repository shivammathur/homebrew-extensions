# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT74 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.2.tgz"
  sha256 "8742427ff7c07ba93f940968f7363972ea040d97d847da3b79b4283c2a369dea"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "00edfb94b9ffc8eefc979919f032d4d8fde98196d2e517f3303821ca2ca3ad76"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "359a683653bc725a842c853b3fc747389c76b3e4fb7f40d34f5da234f1fab05c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2a68f176dffa977a7df82a0c8e9fe72dc080336d989e68866001b0204bddf819"
    sha256 cellar: :any_skip_relocation, ventura:        "e333ca6b74e97ae93049232ee162a3e92450e03224a3441f97f246947d98114b"
    sha256 cellar: :any_skip_relocation, monterey:       "0bd2c20051bba4c2c49d79f2cb6979b0804358675dd8441a9b430220f09d3833"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5ea5ac129a65337fa9ebf5236c534f74f589df3fb03c7c1152691a17eea99df3"
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
