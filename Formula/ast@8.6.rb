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
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "ce09961c3bfcc544a3df48bee3aba35cce02c0bef2d07c8e225eaa1c6cc0726c"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "0138b562ef6995c0ef3de8ec7bb2751957f41e567d0abf5c06bfc287dc4c8f5e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "97395489ba73f5b2456a8dad9318018f727c958255dd34b8456ed02b5b946658"
    sha256 cellar: :any,                 arm64_linux:       "2caacbadb0244595785b02e15a4699cea87c26b416b1f1a423e2ca9e3eb9d4e7"
    sha256 cellar: :any,                 x86_64_linux:      "7fe6340d31153147e05c6535188b2c607c0ad00b840ad8365a84909164c80f55"
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
