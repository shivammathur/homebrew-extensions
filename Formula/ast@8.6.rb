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
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "726e2b941a6ba6180f14b4b3c8a965cafb356c7e1c34b00a3789f073e3353d56"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7c458eeae1165f486bcba0bb933139771f775d3bc2df528cd553969a02698839"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "61f916914413260ebdcfa044c3567229b01891af6edbe088affd1f17e7186f2b"
    sha256 cellar: :any_skip_relocation, sonoma:        "1a08de17dc1d367a9242c52874697051f02749045bdfe2ca6d44d80e4b26355e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1e37b0064ebc18aee5d4cb5eb2ef74611ccf4666a574f61442addc44bffe26b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "42b2ce6cf1b0fcd232d97781788a6f033276086fab45fe759172f36f92f8cf5b"
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
