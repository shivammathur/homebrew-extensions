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
  revision 1
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d14cb874c2acaf96485a2fa054e34668e70a9f29afaaf78892bbe723e3e59c7e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c4df1847c754a2922e474d977866cd73fd17cb1bf019fbc33a85de4808d20d39"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e6cfde5f201966dec6dbc41bf4037a21d03e297b948b0fb909c1cc656b533096"
    sha256 cellar: :any_skip_relocation, ventura:       "0d9e19b788a02faddb07a397b3f733411fccbc12904cc6467e2fad1578ac3253"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "00aa31416f655f4e875d18f548dfe076b9cd846fdd69ec2ab85030f86291c19c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ffd543805582b83cc1e49939439322c038b52ce78185c317f3730f49e577e458"
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
