# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "840f6c02d64cc00be7109229c21b8da6b4e8fe74b7b208374e2ea8656356e94f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "328be49cf3d77204f73fc8412ec5329f3b28e397dda0d76d5cbc1ddd20c2a860"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "daeaa7a04a721e3b313cedc2b34679a59d6a3cfac85d57b652fc9285887f95ba"
    sha256 cellar: :any_skip_relocation, ventura:       "9e4c2d241a804e15acbac6dcaa543d419187d6ba30437be41cd66d6cfb7edc14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e534f9c59a93b897fecc78fa321d737895552ba17e9ac1dd2e590865de9faab"
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
