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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "11de863014f987a2a5357b2077ad8a0bdd1c9caf2656e190fad4ece1f9bf7804"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "315774e366294accf44b39ed3b5316c486d28cf2c38aac8d46aac468a9a4fca6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "6bd5eec79b54f93b21107113570801496bad8fadc0e0cfebed6a1b04880e682f"
    sha256 cellar: :any,                 arm64_linux:       "246b20f9312c814829cec8f15b788d84790a90face0ea796c18d4f05d1c39539"
    sha256 cellar: :any,                 x86_64_linux:      "acb89ddb8c7b87a9dbf278fb05db0881587dc35d713206613f0936357c194299"
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
