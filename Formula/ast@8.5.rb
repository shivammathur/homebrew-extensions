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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "617bd089677c8ed2e5b05d4737333f79a59973195b55a52249cbc5907deb46c2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9289640e66d933287f310fb275c10c387388a87d341db6ed1cbc7d4e2c93318a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1689b09243a1d8bf62b8adc1205a1833c85dab4573945b63f5e0aed53b42da1b"
    sha256 cellar: :any_skip_relocation, sonoma:        "acea329d97778a48643bf189481b8884e299a03bdfbbea7b898ed34d6145bbdc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4bc9043bc6de5636e216f0fc96d6e2e76e0b2f29d233e1a9f95ad9e31b6ba10d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "70189e4f2f02cdaf78ab94d678e1a8843efe9ecb6149591a757dec16e091e82e"
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
