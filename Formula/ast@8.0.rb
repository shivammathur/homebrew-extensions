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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "490e66cfee0f37d6a66936e65abc601a318175fc81aaf01acb5eb71ffb04715b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0ab184b9ba386320f64bba31f0c7fb7f9ed7bf74cc9c5a888a2119e667d8e4fa"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b5c816c70c90d4117f19af4d1cd8d5d65db3c1f8adc4874a975a482b28b06ece"
    sha256 cellar: :any_skip_relocation, ventura:       "8131c6c7afb8b40802f3828741b31b17a065e1313a3245743125770652a16fb0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bfb93a5349df90f0148d04fa042a696631dc65ab149dd36b84e8ba219437fd87"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9baed4cad7822ae4c5756499402bb38c2cf6b77454208863ce787fa07c0c3618"
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
