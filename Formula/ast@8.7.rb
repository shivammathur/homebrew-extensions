# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT87 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.3.tgz"
  sha256 "528b54aabcfce6bf0e94b5940a73cca357d4a52fad9fef4cd4dc025abc1a9fbd"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
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
