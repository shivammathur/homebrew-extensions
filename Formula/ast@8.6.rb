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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1a9e66f3c83ec782be78c7a4e35b91965e29aeefad0c3864126411fd45284bbe"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dc5e867fa13420660e309d3b1e4292efa627a6f8ce851cf4d03e764988bf72e3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "59f50e94e0031443fbe99767e82507c154c4f2389254ed07b7135f37221f43c5"
    sha256 cellar: :any_skip_relocation, sonoma:        "3f66af8210ba862fd02cf1cba52aa5ac9820a81f4373e7424e23f70981f8a5d6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a0fd2fecfe609423d93bc3429ccf08a61f2a6cc4bb49b1b6673ba162faec15d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f06e2b3087c5a0488cd53a47ea511b1ec4dcba309d2638a9647293dac0b4fb78"
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
