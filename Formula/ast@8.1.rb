# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT81 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.0.tgz"
  sha256 "ee3d4f67e24d82e4d340806a24052012e4954d223122949377665427443e6d13"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "da757414a4a694a373121d5c998a430e67e160ca31e26853edb297a09cc77fe9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8400357dd7e021746ef3b8edfeeb0a487945494902a10325864d75b6128d1a9e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4d92b193208aac9ff640f318394350713ceeffce315f276f73771a87f5cdac48"
    sha256 cellar: :any_skip_relocation, ventura:        "e1c045f1100c0d6f9e603adc6b36091a88189da5b6ba16beef8d56f23908957c"
    sha256 cellar: :any_skip_relocation, monterey:       "40cb2ab35fd97ae45b11284f32a00ebff6a3893d550273371556573c06bc277c"
    sha256 cellar: :any_skip_relocation, big_sur:        "52adf7a2a5585193ba74e3ea3a55a9a76f9baff94c5d582e15cec62152a5020f"
    sha256 cellar: :any_skip_relocation, catalina:       "55747292c57c1ed5ae2dd43daf049bd22fdeea12b5bdffa90858c0b85d7a2e80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a9898a9e829ab3d410651b3f9fec6fe10c0c352a1f1687ee51a3a2ac1cc9fa4"
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
