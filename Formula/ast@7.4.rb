# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "520fa949154ba9c4f000189211129b364e489f11633d93f365d207a5b15dd5c3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9c05c8d51f3825b8b3d5aa63fcb466e7db32dda4481847ce0ac3035b29b40a53"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b61d35f27728624204440d756ebe810bf37e5ee50789b5ed32b00dfc6a21c7a2"
    sha256 cellar: :any_skip_relocation, sonoma:        "e5b5ca5698644302587cae9e93ae001d0b2ac97e5e57cd444ddf0bffdefc9737"
    sha256 cellar: :any_skip_relocation, ventura:       "67745ccc842fadc520dfefa5452b6ffff09c384415b1a8d93b581d2adaa7e97a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6f8146c5c46eb7e00917a3c3abbb0f39d666ed851653973446eff0ddab88144b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4079182095782307071dbd79a0b3f0f02fd3d28431e41b70057e490fbba20aca"
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
