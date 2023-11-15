# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT83 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.1.tgz"
  sha256 "0c55e09a4da43b9cc1da72ecb4ae892941f73e157b73d46326bc6a5ed7fc44b1"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5db141b9f3a39617027ca9b46a94c72ada93a71326e740f287b032ff12fc2fa7"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5fcedb2717cac6b5e6ef8a79c60f66435037e28c2d7ef97495af0e724b039c4b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "37aa00bdf4124e4c579c2648063cac46ddc376a824e6cdf9fe11a2286745cc04"
    sha256 cellar: :any_skip_relocation, ventura:        "c5d83ec3a95a28e04828987124dff945586de6af4fb99352268af3ccd5629030"
    sha256 cellar: :any_skip_relocation, monterey:       "c77d1670455c1e70d60e87a038b92cadde1232113cd4df31192ec4ed0af68f47"
    sha256 cellar: :any_skip_relocation, big_sur:        "ec93ed87d4c121918edcee29469a08f74eb996f78993a1544a22d17f659f995c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c18b2c5d6ae19dc43c63ddba5d3164698bec2ec32f99abef106c90452a64809a"
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
