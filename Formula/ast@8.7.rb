# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT87 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.4.tgz"
  sha256 "28728fb8bfd8b0eddccd241f92f0be0a45d83250e5a0cd6e1876c0c533ab3658"
  revision 2
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b169b118faad0a4efc2181ec6fa301d083a73525d61e9372b79c405a50f6caeb"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f76e06bddb0f947c1f2f00a819ce77f56402a3e9a2540c6688350660f045d69a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "17fb9055c42650de5f03db6d59b79230b7bb93377112cd75d2cb9c1f2aff8208"
    sha256 cellar: :any,                 arm64_linux:       "8356bebe3ca4db76ae04442f4889585c3570ba8f950a5a83c6e4bbf4a33f3865"
    sha256 cellar: :any,                 x86_64_linux:      "5fa7f85355c0c423cbe78f455c6ff528950bd9accf39ddc701da8a8f8e103b98"
  end

  def install
    Dir.chdir "ast-#{version}"
    %w[ast.c ast_data.c].each do |f|
      inreplace f, "ZEND_AST_METHOD_REFERENCE", "ZEND_AST_TRAIT_METHOD_REFERENCE"
    end
    inreplace "ast.c", "zend_parse_parameters_throw", "zend_parse_parameters"
    inreplace "ast.c", "ZEND_PARSE_PARAMS_THROW", "0"
    inreplace "ast.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE();"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ast"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
