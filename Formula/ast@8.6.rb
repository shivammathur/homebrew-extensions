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
  revision 1
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "dd77ddb10c50884b04e38ab801ea7d4dcaff0febd405fb774eaf4bca89d269d8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "538ed187046ddc9cc311d6e7fd9a3284f4a4808077346d34c2e7f57d779a36b6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "777dee792106052687de2fece68bf10db54b165914d52c14f420affb531c5eec"
    sha256 cellar: :any_skip_relocation, sonoma:        "0dbfbc3e6ce2b38b55aefdc402cb5d0d3d6b37e68d0e70058e0ce828e645376f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c3fd5df6b35cfe0edadcf79c9e7c082004584c7eff67f77bdf8afc06136763b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "549dc37655f948ad1f329db9eaf64fa7a7833953f0e339cecf43d359e353a497"
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
