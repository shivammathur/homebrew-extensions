# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8faa24fcf20a77ac43805b855cb316c2768d56ff196b9a7da5e8a53d0667ad29"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "19878b4c6fff72c60428ddb0b75413982b0a6df1ddb293996ba1a9a016e9e7cf"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4348c61b72c1d58c625a8b9cc416f95743af1727281343bf0f5e710b85812917"
    sha256 cellar: :any_skip_relocation, sonoma:        "60991c359fea78ce26ad72a3f0025d81f85e1627f788c19ef81ae94791d8ffb9"
    sha256 cellar: :any_skip_relocation, ventura:       "1dcac82b73e400cfd4e978dd7a10c460cf91c677ec71618971d01edac48aa6a5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "170bea54f14f4086b07ededca0b60e245a2d2e0363236247276b734f3754a781"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b1ba29c976ea041c624ab1b04304dab40cb9d9fe02fab3dba9ce57f6cc6e08e"
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
