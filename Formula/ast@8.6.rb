# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT86 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.3.tgz"
  sha256 "528b54aabcfce6bf0e94b5940a73cca357d4a52fad9fef4cd4dc025abc1a9fbd"
  revision 2
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "e6d60ec3834b6dd8ed6640f68e01fd63c809a6bba554d6956f19018385b518b2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "babe724b62e73860c284d43244ba08b10b184b7aaf73f0034ad7973596f69b8d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "eb21fbecaafec77747936d881d19f3951a44322e21d66046c949553078d9c8fd"
    sha256 cellar: :any,                 arm64_linux:       "a3a9d3cd6e16fec07be0cb307833fee55a21e1323c146b84ff5fd9567135c707"
    sha256 cellar: :any,                 x86_64_linux:      "df7619d3797f5e167e753c1bd984cace5cfe105abc286306f2dd374b04d98a46"
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
