# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT86 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.4.tgz"
  sha256 "28728fb8bfd8b0eddccd241f92f0be0a45d83250e5a0cd6e1876c0c533ab3658"
  revision 1
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "a8f9bb2b80aeb69a464edde572083ea59948b739e574f8c973c6eca2f535f581"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "fd6c3186108faf7207bf9ae131af3272eeba33b70a52615c587d1cc61229cf78"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "37154c9c97d8b6ffe1f57dbef8cbeebd71b13f4616d2fcfada2485c1259df0a9"
    sha256 cellar: :any,                 arm64_linux:       "fae9e10f2c2159ff2dca890518fe7b25d127ed3d785da54ca02631c6b717c7a8"
    sha256 cellar: :any,                 x86_64_linux:      "a53889c4a4a7c0436980d8bda182b3c4512d70257601d4f91ce86d991e9cae64"
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
