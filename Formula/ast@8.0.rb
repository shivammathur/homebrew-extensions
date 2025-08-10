# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT80 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.3.tgz"
  sha256 "528b54aabcfce6bf0e94b5940a73cca357d4a52fad9fef4cd4dc025abc1a9fbd"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "b2a9226e43e057d0e8c6880ad8f89f97c33d1fdae95aa4852bb49024a4fc2af6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "5e7246c70e1fc0dec8b03f45a270c0aee37ab8a19ebf791b8dbc7e527399f3c1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3ed15424d56907724ddb5b04190af27f0942d6eb7d6815cdb61e20980f462aff"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "97398a86bf9c531d11a88c5aa3d6c28000addd5e5cf704d669e543806eb105ad"
    sha256 cellar: :any_skip_relocation, ventura:        "af661e705e2190638e93f04fc6018c53a175fed9173eb45434bc77d88fedf3ac"
    sha256 cellar: :any_skip_relocation, monterey:       "a96405d0c126b97d5018d2fc52298cad3b5f75f51bda35e1e9153df915fe00aa"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "8ffe0c9fe76d1408b78563617e7f1b9f09401d8b9fe9c9e8c7fee18137a64401"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0751d79fdfb97c7fa44e59641c0dd52e83712de6f0a6dd18efb82761a0d8655a"
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
