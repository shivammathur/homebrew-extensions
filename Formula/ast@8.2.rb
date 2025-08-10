# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "648b1adbe4acf409765aeef148f7118391c456c6c6f57e0cdbea0dc668db10c0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "00f3a39101c30d759792e9fcd161c48cd99934bea1ab979d99e54f3790c3ca99"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5bad3ec1534401975960bbe3b97b1eb8787dbfd74f39cf1525f4d3ff7acbaf50"
    sha256 cellar: :any_skip_relocation, ventura:       "943c36b4cc1dfa4280b68e3fdbb4eaf33f72aef4daea11cd4a46c6a0e24b0ee2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6e4ec786b8c6c4accdc51b36078e4bd4c7d48285dbff58e22c36e5376c6a104c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d70c230883c45a4bf529f9eeff6983a6682c4c051e963ba34277ae0009f4edb7"
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
