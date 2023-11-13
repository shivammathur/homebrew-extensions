# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0c000616aaa468eb3a34f347b852e6ff9112c25e135f871ab45548a25091a3ee"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f8083d642f77110cfbf9eca54827d6a79f9250426ffd50095d5919e0539da4fa"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6b5958e642959f84a1081dc196ee3d80dc2ddf538d15a48089671f7ab1e53074"
    sha256 cellar: :any_skip_relocation, ventura:        "fac83f562823da97a3573b16599fb4733b2f7e4c166079ea3c420414106f95da"
    sha256 cellar: :any_skip_relocation, monterey:       "308b1a6397fa107e2c19b4baa4fc00bdc9ed89d4ee8b603ebc4dd718c3278409"
    sha256 cellar: :any_skip_relocation, big_sur:        "aeb422633f425aef585bafb5793cbd65ff8570fff59d34ed096753a8324fe427"
    sha256 cellar: :any_skip_relocation, catalina:       "29d1ab8a45dd3192da965391faa86c8b5d39f32c90931cd4711c72be1ee779ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "66b9e6bf73f03a0a971e0a3ee5a35300dba3cf890ba55fefa388703b2b979306"
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
