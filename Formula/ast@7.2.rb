# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "db1d1b79b9961ac4f4bd7b54e90ce24328df28a6f8e0871ffba6949f618a196a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eb8ff2b329e78ce52b25a53941499abe6a2363180468cdd35bed74487f56c5e7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "358d0bfbc49de6de34a43c40053690584f2bfefc2cb2f2cd5ae7086325acba1f"
    sha256 cellar: :any_skip_relocation, ventura:       "cb0d654da0bd67c2b754185e683bdb78603336ad8f59ace79acd12177ccd1947"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7706d9a345cd7624936fc1c06cf8339150e6337b41f8f1ca5525293756eac1dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4d33ad07c67d3d51c44eb74721d5bee1c0ffa0f256a5c20b4dec687a6529ebaa"
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
